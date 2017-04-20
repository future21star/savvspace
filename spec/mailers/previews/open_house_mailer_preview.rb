# Preview all emails at http://localhost:3000/rails/mailers/open_house
class OpenHouseMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/open_house/favorites
  def favorites
    user = User.find_by(email: "openhousepreview@example.com") || FactoryGirl.create(:user, email: "openhousepreview@example.com")
    mls_server = MlsServer.first || FactoryGirl.create(:mls_server)

    referrer = Profile.first || FactoryGirl.create(:profile)
    referrer.avatar_url = "http://res.cloudinary.com/hudgq2erh/image/upload/v1484954309/v9xu49khza8dgokqncwx.jpg" unless referrer.avatar
    referrer.save

    if user.favorite_items.open_houses.count < 3
      open_houses = [FactoryGirl.create(:open_house, mls_server: mls_server)]
      open_houses.each { |oh| user.favorite_items.create(favorite: oh) }
    end

    OpenHouseMailer.favorites(user, referrer)
  end

  # Preview this email at http://localhost:3000/rails/mailers/open_house/favorites
  def single_property
    user = User.find_by(email: "openhousepreview@example.com") || FactoryGirl.create(:user, email: "openhousepreview@example.com")
    referrer = Profile.first || FactoryGirl.create(:profile)
    referrer.avatar_url = "http://res.cloudinary.com/hudgq2erh/image/upload/v1484954309/v9xu49khza8dgokqncwx.jpg" unless referrer.avatar
    referrer.save
    mls_server = MlsServer.first || FactoryGirl.create(:mls_server)
    open_house = FactoryGirl.create(:open_house, mls_server: mls_server)

    OpenHouseMailer.single_property(user, open_house, referrer)
  end

end
