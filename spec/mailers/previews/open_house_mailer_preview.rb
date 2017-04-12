# Preview all emails at http://localhost:3000/rails/mailers/open_house
class OpenHouseMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/open_house/favorites
  def favorites
    user = User.find_by(email: "openhousepreview@example.com") || FactoryGirl.create(:user, email: "openhousepreview@example.com")
    mls_server = MlsServer.first || FactoryGirl.create(:mls_server)

    if user.favorite_items.open_houses.count < 3
      open_houses = [FactoryGirl.create(:open_house, mls_server: mls_server)]
      open_houses.each { |oh| user.favorite_items.create(favorite: oh) }
    end

    OpenHouseMailer.favorites(user)
  end

end
