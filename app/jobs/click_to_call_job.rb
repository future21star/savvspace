class ClickToCallJob < ActiveJob::Base
  queue_as :default

  def perform(phone_call)
    client = Twilio::REST::Client.new
    placed_call = client.calls.create(from: '+18052090165',
                                      to: phone_call.from_phone.number,
                                      applicationSid: ENV.fetch('CLICK_TO_CALL_SID'))
    phone_call.update(sid: placed_call.sid)
    placed_call
  end
end
