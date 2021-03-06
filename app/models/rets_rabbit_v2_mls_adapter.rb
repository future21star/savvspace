class RetsRabbitV2MlsAdapter < MlsAdapter
  include HTTParty

  def self.access_token
    Rails.cache.fetch("rets_access_token_#{ENV.fetch('RETS_RABBIT_CLIENT_ID')}",
                      expires_in: 302_400) do
      if Rails.env.test?
        'test123'
      else
        response = post('/oauth/access_token',
                        body: {
                          grant_type: 'client_credentials',
                          client_id: ENV.fetch('RETS_RABBIT_CLIENT_ID'),
                          client_secret: ENV.fetch('RETS_RABBIT_SECRET')
                        })
        response['access_token']
      end
    end
  end

  base_uri ENV['RETS_RABBIT_URL']
  format :json
  headers 'Authorization' => "Bearer #{RetsRabbitV2MlsAdapter.access_token}",
          'Accept' => 'application/json'
  debug_output $stdout

  def metadata
    RetsProvider.get('/datasystem')
  end

  def servers
    RetsProvider.get('/v1/server')
  end

  def property_list(search)
    response = RetsProvider.get('/v2/property',
                                query: v2_property_search_to_query(search))
    if response.parsed_response['value'].blank?
      Rails.logger.error(response.inspect)
      []
    else
      response.parsed_response['value']
    end
  end

  def property_search_to_query(property_search)
    query = { '$top' => 12, '$skip' => 0 }

    filter = []

    filter << "ListPrice ge #{property_search.min_price}" if property_search.min_price.present?
    filter << "ListPrice le #{property_search.max_price}" if property_search.max_price.present?
    filter << "BedroomsTotal ge #{property_search.min_beds}" if property_search.min_beds.present?
    filter << "BedroomsTotal le #{property_search.max_beds}" if property_search.max_beds.present?

    query['$filter'] = filter.join(' and ') if filter.present?

    query['$orderby'] = case property_search.sort_by
                        when PropertySearch::SORT_PRICE_LOW_TO_HIGH
                          'ListPrice asc'
                        when PropertySearch::SORT_PRICE_HIGH_TO_LOW
                          'ListPrice desc'
                        else
                          'ListingContractDate desc'
                        end

    query
  end
end
