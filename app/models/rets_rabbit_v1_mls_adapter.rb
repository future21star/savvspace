class RetsRabbitV1MlsAdapter < MlsAdapter
  include HTTParty

  def self.access_token
    Rails.cache.fetch("rets_access_token_#{ENV.fetch('RETS_RABBIT_CLIENT_ID')}", expires_in: 302400) do
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
  debug_output $stdout

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
        response.parsed_response["results"]
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
    mls_server.properties.new(mls_data: self.class.get("/v1/#{mls_server.server_hash}/listing/#{id}").parsed_response)
  end

  def photo_for_listing(mls_server, id)
    listing = listing(mls_server, id)
    if listing["photos"].empty?
      nil
    else
      listing["photos"].first["url"]
    end
  end

  def property_search_to_query(property_search)
    query = {
      "limit" => 12,
      "offset" => 0,
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

  def build_open_house(mls, struct)
    OpenHouse.new(mls_server_id: mls.id,
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
                  photo_url: photo_for_listing(mls, struct["fields"]["LIST1"]))
  end
end
