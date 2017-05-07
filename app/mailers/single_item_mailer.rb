class SingleItemMailer < ApplicationMailer
  helper :open_houses

  def self.send_item_request(sender_id, profile_id, recepients, item_id, item_type)
   recepients.each do |receiver|
     send_item(sender_id, profile_id, receiver, item_id, item_type).deliver_later
   end
 end

 def send_item(sender_id, profile_id, receiver, item_id, item_type)
   @sender_user = User.find(sender_id)
   @sender_profile = Profile.find(profile_id)
   @items = [find_item(item_id, item_type)]

   mail(
     from: @sender_user.email,
     to: receiver,
     reply_to: @sender_user.email,
     subject: "#{@sender_profile.name} wants you to see this property at Savvspace"
    )
 end

end
