class RetsRabbitV1MlsAdapter < MlsAdapter
  include HTTParty

  def self.access_token
    Rails.cache.fetch("rets_access_token_#{ENV.fetch('RETS_RABBIT_CLIENT_ID')}", expires_in: 302400) do
      Rails.logger.debug("Entering access_token")
      if Rails.env.test?
        "test123"
      else
        response = post("/oauth/access_token",
                        body: {
                          grant_type: "client_credentials",
                          client_id: ENV.fetch('RETS_RABBIT_CLIENT_ID'),
                          client_secret: ENV.fetch('RETS_RABBIT_SECRET')
                        })
        response["access_token"]
      end
    end
  end

  base_uri ENV['RETS_RABBIT_URL']
  format :json
  headers  "Authorization" => "Bearer #{self.access_token}", "Accept" => "application/json"
  # debug_output Rails.logger

  def metadata
    self.class.get("/datasystem")
  end

  def servers
    self.class.get("/v1/server")
  end

  def property_list(search)
    query = property_search_to_query(search)

    Rails.cache.fetch("rets_rabbit_v1_property_search_#{query.hash.to_s}", expires_in: 10.minutes) do
      response = self.class.get("/v1/#{search.mls_server.server_hash}/listing/search",
                                  query: property_search_to_query(search))

      if response.parsed_response["results"].blank?
        Rails.logger.error(response.inspect)
        []
      else
        response.parsed_response["results"].map { |s| build_property(search.mls_server, s) }
      end
    end
  end

  def open_house_list(search)
    response = self.class.get("/v1/#{search.mls_server.server_hash}/open_house/search",
                                query: open_house_search_to_query(search)
                                )
    if response.parsed_response["results"].blank?
      Rails.logger.error(response.inspect)
      []
    else
      response.parsed_response["results"].map { |s| build_open_house(search.mls_server, s) }
    end
  end

  def listing(mls_server, id)
    build_property(mls_server, self.class.get("/v1/#{mls_server.server_hash}/listing/#{id}").parsed_response)
  end

  def photo_for_listing(mls_server, id)
    listing = listing(mls_server, id)
    if listing.photos.empty?
      nil
    else
      listing.photos.first
    end
  end

  def property_search_to_query(property_search)
    query = {
      "limit" => property_search.limit,
      "offset" => property_search.offset,
      "LIST_15" => "Active",
      "LIST_9" => "Home/Estate"
    }

    if property_search.min_price.present? && property_search.max_price.present?
      query["LIST_22"] = "#{property_search.min_price}-#{property_search.max_price}"
    elsif property_search.min_price.present?
      query["LIST_22"] = "#{property_search.min_price}+"
    elsif property_search.max_price.present?
      query["LIST_22"] = "#{property_search.max_price}-"
    end

    if property_search.min_beds.present? && property_search.max_beds.present?
      query["LIST_66"] = "#{property_search.min_beds}-#{property_search.max_beds}"
    elsif property_search.min_beds.present?
      query["LIST_66"] = "#{property_search.min_beds}+"
    elsif property_search.max_beds.present?
      query["LIST_66"] = "#{property_search.max_beds}-"
    end

    case property_search.sort_by
    when PropertySearch::SORT_PRICE_LOW_TO_HIGH
      query["orderby"] = "LIST_22"
      query["sort_order"] = "asc"
      query["sort_option"] = "numeric"
    when PropertySearch::SORT_PRICE_HIGH_TO_LOW
      query["orderby"] = "LIST_22"
      query["sort_order"] = "desc"
      query["sort_option"] = "numeric"
    else
      query["orderby"] = "LIST_10"
      query["sort_order"] = "desc"
      query["sort_option"] = "date"
    end

    query
  end

  def open_house_search_to_query(property_search)
    query = {
      "limit" => 12,
      "offset" => 0,
      "ADD10" => "CA"
    }

    if property_search.min_price.present? && property_search.max_price.present?
      query["LIST_22"] = "#{property_search.min_price}-#{property_search.max_price}"
    elsif property_search.min_price.present?
      query["LIST_22"] = "#{property_search.min_price}+"
    elsif property_search.max_price.present?
      query["LIST_22"] = "#{property_search.max_price}-"
    end

    case property_search.sort_by
    when PropertySearch::SORT_PRICE_LOW_TO_HIGH
      query["orderby"] = "LIST_22"
      query["sort_order"] = "asc"
    when PropertySearch::SORT_PRICE_HIGH_TO_LOW
      query["orderby"] = "LIST_22"
      query["sort_order"] = "desc"
    end

    query
  end

  def open_houses_list(mls, offset=0, result_set = [])
    results = self.class.get("/v1/#{mls.server_hash}/open_house/search",
                             query: {
                               "offset" => 0,
                               "EVENT100:date" => Date.today.to_s + "+"
                             })

    results.parsed_response["results"].map { |r| build_open_house(mls, r) }
  end

  def fetch_property_list(mls_server, offset=0, result_set = [])
    Rails.logger.debug("Fetching 250 properties starting from #{offset}")

    response = self.class.get("/v1/#{mls_server.server_hash}/listing/search",
                              query: { "limit" => 250, "offset" => offset, "LIST_15" => "Active" })

    if response.parsed_response["results"].nil?
      Rails.logger.error(response.parsed_response.inspect)
      raise "Invalid response from MLS Server"
    end

    result_set.concat(response.parsed_response["results"].map { |s| build_property(mls_server, s) })

    if response.parsed_response["total_records"] > result_set.size && response.parsed_response["results"].size > 0
      Rails.logger.debug("#{response.parsed_response["total_records"] - result_set.size} more to go...")
      fetch_property_list(mls_server, result_set.size, result_set)
    else
      result_set
    end
  end

  def build_open_house(mls, struct)
    property = mls.properties.find_by(internal_mls_id: struct["fields"]["LIST1"]) ||
      listing(mls, struct["fields"]["LIST1"])
    property.save

    OpenHouse.new(mls_server_id: mls.id,
                  property: property,
                  street_address: struct["fields"]["ADD0"],
                  state: struct["fields"]["ADD10"],
                  area: struct["fields"]["ADD5"],
                  mls_event_id: struct["fields"]["EVENT0"],
                  host_name: struct["fields"]["EVENT8"],
                  host_phone: struct["fields"]["EVENT9"],
                  mls_property_id: struct["fields"]["LIST1"],
                  list_price: struct["fields"]["LIST22"],
                  list_agent_id: struct["fields"]["MBR0"],
                  list_agent_first_name: struct["fields"]["MBR5"],
                  list_agent_last_name: struct["fields"]["MBR7"],
                  list_office_id: struct["fields"]["OFC0"],
                  list_office_name: struct["fields"]["OFC3"],
                  comments: struct["fields"]["OPEN_HOUSE_COMMENT"],
                  list_agent_phone: struct["fields"]["PHONE0"],
                  list_office_phone: struct["fields"]["PHONE1"],
                  starts_at: Time.zone.parse(struct["fields"]["EVENT100"]),
                  ends_at: Time.zone.parse(struct["fields"]["EVENT200"]),
                  photo_url: property.photos.first)
  end

  def build_property(mls, struct)
    Property.new(mls_server_id: mls.id,
                 mls_data: struct,
                 internal_mls_id: struct["fields"]["LIST_1"],
                 listing_id: struct["fields"]["LIST_105"],
                 bedrooms: struct["fields"]["LIST_66"].to_i,
                 full_baths: struct["fields"]["LIST_68"].to_i,
                 half_baths: struct["fields"]["LIST_69"].to_i,
                 list_price: struct["fields"]["LIST_22"].to_i,
                 square_feet: struct["fields"]["LIST_48"].to_i,
                 photos: struct["photos"].map { |p| p["url"] },
                 lat: struct["fields"]["LIST_46"],
                 lng: struct["fields"]["LIST_47"],
                 status: struct["fields"]["LIST_15"],
                 days_on_market: struct["fields"]["LIST_137"].to_i,
                 street_address: format_street_address(struct),
                 city: struct["fields"]["LIST_39"].to_s.titleize,
                 state: struct["fields"]["LIST_40"],
                 zip5: struct["fields"]["LIST_43"],
                 listing_office_name: struct["fields"]["listing_office_name"],
                 listing_office_address: struct["fields"]["listing_office_address"],
                 listing_office_phone: struct["fields"]["listing_office_phone"],
                 listing_member_name: struct["fields"]["listing_member_name"],
                 listing_member_phone: struct["fields"]["listing_member_phone"],
                 listing_member_email: struct["fields"]["listing_member_email"],
                 listing_member_url: struct["fields"]["listing_member_url"],
                 public_remarks: struct["fields"]["LIST_78"],
                 property_type: struct["fields"]["LIST_9"],
                 year_built: struct["fields"]["LIST_53"],
                 topography: struct["fields"]["GF20010504203332657000000000"],
                 county: struct["fields"]["LIST_41"],
                 style: struct["fields"]["GF20010504202751553457000000"],
                 zoning: struct["fields"]["GF20010504204208569501000000"],
                 construction: struct["fields"]["GF20010504202807758598000000"],
                 parking: struct["fields"]["GF20010504203132400453000000"],
                 heating: struct["fields"]["GF20010504203911247356000000"],
                 area: struct["fields"]["LIST_77"],
                 parcel_number: struct["fields"]["LIST_26"],
                 elementary_school: struct["fields"]["LIST_95"],
                 junior_high_school: struct["fields"]["LIST_96"],
                 high_school: struct["fields"]["LIST_97"],
                 mls_updated_at: Time.parse(struct["fields"]["LIST_87"]))
  end

  private

  def format_street_address(struct)
    [
     struct["fields"]["LIST_31"],
     struct["fields"]["LIST_34"],
     struct["fields"]["LIST_37"],
     struct["fields"]["LIST_35"]
    ].reject(&:blank?).join(" ")
  end
end
