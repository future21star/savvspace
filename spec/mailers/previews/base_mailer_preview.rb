class BaseMailerPreview < ActionMailer::Preview

  protected

  def sender
    User.find_by(email: "openhousepreview@example.com") || FactoryGirl.create(:user, email: "openhousepreview@example.com")
  end

  def sender_id
    sender.id
  end

  def profile_id
    profile = Profile.first || FactoryGirl.create(:profile)
    profile.update(avatar_url: "https://www.centraltest.com/sites/all/files/styles/image_title/public/bf5_0.png?itok=vBhllsaA") unless profile.avatar

    profile.id
  end

  def receiver
    'receiver@testmail.com'
  end

  def mls_server
     MlsServer.first || FactoryGirl.create(:mls_server)
  end

  def create_item(item_type)
    FactoryGirl.create(item_type, mls_server: mls_server)
  end

  def generate_favorite_items(item_type)
    items_type = item_type.to_s.pluralize.to_sym

    if sender.favorite_items.send(items_type).count < 3
      items = [create_item(item_type)]
      items.each { |item| sender.favorite_items.create(favorite: item) }
    end
  end
end
