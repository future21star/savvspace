namespace(:properties) do
  task(cache: :environment) do
    MlsServer.find_each do |mls_server|
      mls_server.fetch_property_list.each do |listing|
        property = mls_server.properties.find_or_initialize_by(internal_mls_id: listing.internal_mls_id)
        property.update(listing.attributes.except("id", "created_at", "updated_at"))
      end
    end
  end
end
