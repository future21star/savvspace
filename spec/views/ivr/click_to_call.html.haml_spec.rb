require 'rails_helper'

RSpec.describe "ivr/click_to_call.xml.haml", type: :view do
  let(:phone_call) { FactoryGirl.create(:phone_call) }

  before { assign(:phone_call, phone_call) }

  it "does not throw an error" do
    expect { render }.not_to raise_error
  end
end
