class FavoritesMailer < ApplicationMailer
  helper :open_houses

  def self.send_favorites_request(sender_id, profile_id, recepients, item_type)
   recepients.each do |receiver|
     send_favorites(sender_id, profile_id, receiver, item_type).deliver_later
   end
 end

 def send_favorites(sender_id, profile_id, receiver, item_type)
   @sender_user = User.find(sender_id)
   @sender_profile = Profile.find(profile_id)

   @items = @sender_user.favorite_items.send(item_type.to_sym).collect(&:favorite).sort_by(&:list_price) # TODO: move this logic into model

   mail(
     from: @sender_user.email,
     to: receiver,
     reply_to: @sender_user.email,
     subject: "#{@sender_profile.name} wants you to see all favorite items at Savvspace"
    )
 end

end
