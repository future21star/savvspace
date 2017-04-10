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
      response.parsed_response["results"]
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
end
