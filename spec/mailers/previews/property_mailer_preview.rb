# Preview all emails at http://localhost:3000/rails/mailers/property
class PropertyMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/property/favorites
  def favorites
    user = User.find_by(email: "openhousepreview@example.com") || FactoryGirl.create(:user, email: "openhousepreview@example.com")
    mls_server = MlsServer.first || FactoryGirl.create(:mls_server)

    referrer = Profile.first || FactoryGirl.create(:profile)
    referrer.avatar_url = "http://res.cloudinary.com/hudgq2erh/image/upload/v1484954309/v9xu49khza8dgokqncwx.jpg" unless referrer.avatar
    referrer.save

    if user.favorite_items.properties.count < 3
      properties = [FactoryGirl.create(:property, mls_server: mls_server)]
      properties.each { |p| user.favorite_items.create(favorite: p) }
    end

    PropertyMailer.favorites(user, referrer)
  end

  # Preview this email at http://localhost:3000/rails/mailers/property/favorites
  def single_property
    user = User.find_by(email: "openhousepreview@example.com") || FactoryGirl.create(:user, email: "openhousepreview@example.com")
    referrer = Profile.first || FactoryGirl.create(:profile)
    referrer.avatar_url = "http://res.cloudinary.com/hudgq2erh/image/upload/v1484954309/v9xu49khza8dgokqncwx.jpg" unless referrer.avatar
    referrer.save
    mls_server = MlsServer.first || FactoryGirl.create(:mls_server)
    property = FactoryGirl.create(:property, mls_server: mls_server)

    PropertyMailer.single_property(user, property, referrer)
  end

end
