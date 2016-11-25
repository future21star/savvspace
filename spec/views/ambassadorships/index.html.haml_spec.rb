require 'rails_helper'

RSpec.describe "ambassadorships/index", type: :view do
  before(:each) do
    assign(:ambassadorships, [
      FactoryGirl.build_stubbed(:ambassadorship),
      FactoryGirl.build_stubbed(:ambassadorship)
    ])
  end

  it "renders a list of ambassadorships" do
    render
  end
end
