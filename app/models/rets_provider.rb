class RetsProvider
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

  def initialize
  end

  def metadata
    RetsProvider.get("/datasystem")
  end

  def servers
    RetsProvider.get("/v1/server")
  end

  def v1_property_list(search)
    query = v1_property_search_to_query(search)

    Rails.cache.fetch("property_search_#{query.hash.to_s}", expires_in: 10.minutes) do
      response = RetsProvider.get("/v1/4ddfb54ef491a7a1d383c0aba813e2ee/listing/search",
                                  query: v1_property_search_to_query(search))

      if response.parsed_response["results"].blank?
        Rails.logger.error(response.inspect)
        []
      else
        response.parsed_response["results"]
      end
    end
  end

  def v1_open_house_list(search)
    response = RetsProvider.get("/v1/4ddfb54ef491a7a1d383c0aba813e2ee/open_house/search",
                                query: v1_open_house_search_to_query(search)
                                )
    if response.parsed_response["results"].blank?
      Rails.logger.error(response.inspect)
      []
    else
      response.parsed_response["results"]
    end
  end

  def v2_property_list(search)
    response = RetsProvider.get("/v2/property",
                                query: v2_property_search_to_query(search)
                                )
    if response.parsed_response["value"].blank?
      Rails.logger.error(response.inspect)
      []
    else
      response.parsed_response["value"]
    end
  end

  def v1_property_search_to_query(property_search)
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

  def v1_open_house_search_to_query(property_search)
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

  def v2_property_search_to_query(property_search)
    query = {
      "$top" => 12,
      "$skip" => 0
    }

    filter = []
    filter << "ListPrice ge #{property_search.min_price}" unless property_search.min_price.blank?
    filter << "ListPrice le #{property_search.max_price}" unless property_search.max_price.blank?
    filter << "BedroomsTotal ge #{property_search.min_beds}" unless property_search.min_beds.blank?
    filter << "BedroomsTotal le #{property_search.max_beds}" unless property_search.max_beds.blank?

    query["$filter"] = filter.join(" and ") unless filter.empty?

    query["$orderby"] = case property_search.sort_by
                        when PropertySearch::SORT_PRICE_LOW_TO_HIGH
                          "ListPrice asc"
                        when PropertySearch::SORT_PRICE_HIGH_TO_LOW
                          "ListPrice desc"
                        else
                          "ListingContractDate desc"
                        end

    query
  end
end
