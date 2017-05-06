class PropertyMailer < ApplicationMailer
  helper :open_houses

  def self.send_single_property_request(sender_id, profile_id, property_id, recepients)
   recepients.each do |receiver|
     send_single_property(sender_id, profile_id, property_id, receiver).deliver_later
   end
 end

 def send_single_property(sender_id, profile_id, property_id, receiver)
   @sender_user = User.find(sender_id)
   @sender_profile = Profile.find(profile_id)
   @properties = [Property.find(property_id)]

   mail(
     from: @sender_user.email,
     to: receiver,
     subject: "#{@sender_profile.name} wants you to see this item at Savvspace"
    )
 end

end
