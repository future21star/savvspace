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
   @receiver = receiver

   @item = find_item_by(item_id, item_type)

   mail(
     from: @sender_user.email,
     to: @receiver,
     reply_to: @sender_user.email,
     template_name: item_type.underscore,
     subject: I18n.t('single_item_mailer.subject', referrer_name: @sender_profile.name)
    )
 end

 private

 def find_item_by(item_id, item_type)
   item_type.constantize.find(item_id)
 end

end
