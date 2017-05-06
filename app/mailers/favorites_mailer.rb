class FavoritesMailer < ApplicationMailer
  helper :open_houses

  def self.send_favorites_request(sender_id, profile_id, recepients)
   recepients.each do |receiver|
     send_favorites(sender_id, profile_id, receiver).deliver_later
   end
 end

 def send_favorites(sender_id, profile_id, receiver)
   @sender_user = User.find(sender_id)
   @sender_profile = Profile.find(profile_id)
   @properties = @sender_user.favorite_items.properties.collect(&:favorite).sort_by(&:list_price) # TODO: move this logic into model

   mail(
     from: @sender_user.email,
     to: receiver,
     subject: "#{@sender_profile.name} wants you to see all favorites at Savvspace"
    )
 end

end
