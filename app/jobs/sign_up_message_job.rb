class SignUpMessageJob < ActiveJob::Base
  queue_as :default

  def perform(email)
    client = Twilio::REST::Client.new

    client.messages.create(
      from: ENV['FROM_SMS_PHONE_NUMBER'],
      to: ENV['TO_SMS_PHONE_NUMBER'],
      body: I18n.t('message.sign_up', email: email)
    )
  end
end
