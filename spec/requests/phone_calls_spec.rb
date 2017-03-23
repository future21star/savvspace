require 'rails_helper'

RSpec.describe "PhoneCalls", type: :request do
  describe "GET /phone_calls" do
    it "works! (now write some real specs)" do
      get phone_calls_path
      expect(response).to have_http_status(200)
    end
  end
end
