require 'rails_helper'

RSpec.describe "ambassadorships/_embedded_form", type: :view do
  before do
    assign(:ambassadorship,
           FactoryGirl.build_stubbed(:ambassadorship))
  end

  it "does not raise an error" do
    expect { render }.not_to raise_error
  end
end
