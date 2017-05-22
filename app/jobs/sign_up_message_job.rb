class SignUpMessageJob < ActiveJob::Base
  queue_as :default

  def perform(email)
    client = Twilio::REST::Client.new

    client.messages.create(
      from: ENV['SAVVSPACE_PHONE_NUMBER'],
      to: ENV['SIGNUP_SMS_PHONE_NUMBER'],
      body: I18n.t('message.sign_up', email: email)
    )
  end
end
