class FavoritesMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:8080/rails/mailers/favorites_mailer
  def send_favorite_properties
    sender = User.find_by(email: "openhousepreview@example.com") || FactoryGirl.create(:user, email: "openhousepreview@example.com")
    sender_id = sender.id

    profile = Profile.first || FactoryGirl.create(:profile)
    profile.avatar_url = "https://www.centraltest.com/sites/all/files/styles/image_title/public/bf5_0.png?itok=vBhllsaA" unless profile.avatar
    profile.save
    profile_id = profile.id

    receiver = 'test@email.com'

    mls_server = MlsServer.first || FactoryGirl.create(:mls_server)
    if sender.favorite_items.properties.count < 3
      properties = [FactoryGirl.create(:property, mls_server: mls_server)]
      properties.each { |property| sender.favorite_items.create(favorite: property) }
    end

    item_type = 'properties'

    FavoritesMailer.send_favorites(sender_id, profile_id, receiver, item_type)
  end

  def send_favorite_open_houses
    sender = User.find_by(email: "openhousepreview@example.com") || FactoryGirl.create(:user, email: "openhousepreview@example.com")
    sender_id = sender.id

    profile = Profile.first || FactoryGirl.create(:profile)
    profile.avatar_url = "https://www.centraltest.com/sites/all/files/styles/image_title/public/bf5_0.png?itok=vBhllsaA" unless profile.avatar
    profile.save
    profile_id = profile.id

    receiver = 'test@email.com'

    mls_server = MlsServer.first || FactoryGirl.create(:mls_server)
    if sender.favorite_items.open_houses.count < 3
      open_houses = [FactoryGirl.create(:open_house, mls_server: mls_server)]
      open_houses.each { |open_house| sender.favorite_items.create(favorite: open_house) }
    end

    item_type = 'open_houses'

    FavoritesMailer.send_favorites(sender_id, profile_id, receiver, item_type)
  end

end
