class RetsProvider
  include HTTParty

  def self.access_token
    Rails.cache.fetch("rets_access_token", expires_in: 302400) do
      response = post("/oauth/access_token",
                      body: {
                        grant_type: "client_credentials",
                        client_id: ENV.fetch('RETS_RABBIT_CLIENT_ID'),
                        client_secret: ENV.fetch('RETS_RABBIT_SECRET')
                      })
      response["access_token"]
    end
  end

  base_uri ENV['RETS_RABBIT_URL']
  format :json
  headers  "Authorization" => "Bearer #{self.access_token}", "Accept" => "application/json"
  # debug_output $stdout

  def initialize
  end

  def metadata
    RetsProvider.get("/datasystem")
  end

  def property_search(last_name)
    RetsProvider.get("/v2/property",
                     query: {
                       "$filter" => "LastName eq '#{last_name}'"
                     })
  end

  def property_list
    RetsProvider.get("/v2/property",
                     query: {
                       "$orderby" => "ListingContractDate desc",
                       "$top" => 12,
                       "$skip" => 0
                     }).parsed_response["value"]
  end
end
