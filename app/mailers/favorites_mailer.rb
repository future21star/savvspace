class FavoritesMailer < ApplicationMailer
  helper :open_houses

  def self.send_favorites_request(sender_id, profile_id, recepients, item_type)
   recepients.each do |receiver|
     send_favorites(sender_id, profile_id, receiver, item_type).deliver_later
   end
 end

 def send_favorites(sender_id, profile_id, receiver, item_type)
   @sender = User.find(sender_id)
   @referrer = Profile.find(profile_id)
   @receiver = receiver

   @sending_away = sending_away?(@sender, @receiver)
   @items = @sender.favorite_items.send(item_type.to_sym).collect(&:favorite).sort_by(&:list_price)

   mail(
     from: @sender.email,
     to: @receiver,
     reply_to: @sender.email,
     template_name: 'favorites',
     subject: I18n.t('favorites_mailer.subject', referrer_name: @referrer.name, item_type: item_type)
    )
 end

end
