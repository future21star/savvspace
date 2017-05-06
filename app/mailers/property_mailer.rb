class PropertyMailer < ApplicationMailer
  helper :open_houses

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.open_house.favorites.subject
  #
  def favorites(user, referrer)
    @properties = user.favorite_items.properties.collect(&:favorite).sort_by(&:list_price)
    @referrer = referrer

    mail to: user.email
  end

  def self.send_single_property_request(sender_id, property_id, recepients)
   recepients.each do |receiver|
     send_single_property(sender_id, property_id, receiver).deliver_later
   end
 end

 def send_single_property(sender_id, property_id, receiver)
   @sender_user = User.find(sender_id)
   @sender_profile = @sender_user.profile
   @properties = [Property.find(property_id)]

   mail(
     from: @sender_user.email,
     to: receiver,
     subject: "#{@sender_profile.name} wants you to see this item at Savvspace",
     template_name: 'items'
    )
 end

end
