require 'rails_helper'

RSpec.describe ClickToCallJob, type: :job do
  let(:job) { ClickToCallJob.new }

  let(:create_call_response) do
    File.read(File.join(Rails.root, "spec", "fixtures", "twilio", "create-call.json"))
  end

  before do
    FakeWeb.register_uri(:post,
                         %r|api.twilio.com/2010-04-01/Accounts/#{ENV.fetch('TWILIO_SID')}/Calls.json|,
                         :response => create_call_response)
  end

  describe "#execute" do
    let(:phone_call) { FactoryGirl.create(:phone_call) }

    it "creates a call to twilio" do
      call = job.perform(phone_call)
      expect(call).to be_kind_of(Twilio::REST::Call)
    end

    it "updates the local phone call instance with the SID from Twilio" do
      call = job.perform(phone_call)
      expect(call.sid).not_to be_blank
      expect(phone_call.reload.sid).to eq(call.sid)
    end
  end
end
