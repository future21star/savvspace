require 'rails_helper'

RSpec.describe IvrController, type: :controller do

  describe "GET #click_to_call" do
    context "when given a valid CallSid" do
      let(:phone_call) { FactoryGirl.create(:phone_call) }

      it "returns http success" do
        request.accept = 'application/xml'
        get :click_to_call, { 'CallSid' => phone_call.sid }
        expect(response).to have_http_status(:success)
      end
    end
  end

end
