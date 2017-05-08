class SingleItemMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:8080/rails/mailers/single_item_mailer
  def send_property
    sender = User.find_by(email: "openhousepreview@example.com") || FactoryGirl.create(:user, email: "openhousepreview@example.com")
    sender_id = sender.id

    profile = Profile.first || FactoryGirl.create(:profile)
    profile.avatar_url = "https://www.centraltest.com/sites/all/files/styles/image_title/public/bf5_0.png?itok=vBhllsaA" unless profile.avatar
    profile.save
    profile_id = profile.id

    receiver = 'test@email.com'

    mls_server = MlsServer.first || FactoryGirl.create(:mls_server)
    property = FactoryGirl.create(:property, mls_server: mls_server)
    item_id = property.id
    item_type = 'Property'

    SingleItemMailer.send_item(sender_id, profile_id, receiver, item_id, item_type)
  end

  def send_open_house
    sender = User.find_by(email: "openhousepreview@example.com") || FactoryGirl.create(:user, email: "openhousepreview@example.com")
    sender_id = sender.id

    profile = Profile.first || FactoryGirl.create(:profile)
    profile.avatar_url = "https://www.centraltest.com/sites/all/files/styles/image_title/public/bf5_0.png?itok=vBhllsaA" unless profile.avatar
    profile.save
    profile_id = profile.id

    receiver = 'test@email.com'

    mls_server = MlsServer.first || FactoryGirl.create(:mls_server)
    open_house = FactoryGirl.create(:open_house, mls_server: mls_server)
    item_id = open_house.id
    item_type = 'OpenHouse'

    SingleItemMailer.send_item(sender_id, profile_id, receiver, item_id, item_type)
  end

end
