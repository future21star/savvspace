require 'rails_helper'

RSpec.describe "ambassadorships/show", type: :view do
  before(:each) do
    @ambassadorship = assign(:ambassadorship, FactoryGirl.build_stubbed(:ambassadorship))
  end

  it "renders attributes in <p>" do
    render
  end
end
