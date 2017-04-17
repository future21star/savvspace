namespace(:properties) do
  task(cache: :environment) do
    MlsServer.find_each do |mls_server|
      mls_server.fetch_open_house_list.each do |open_house_listing|
        open_house = mls_server.open_houses.find_or_initialize_by(mls_event_id: open_house_listing.mls_event_id)
        open_house.update(open_house_listing.attributes.except("id", "created_at", "updated_at"))
      end
    end
  end
end
