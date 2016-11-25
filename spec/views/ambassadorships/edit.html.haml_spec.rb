require 'rails_helper'

RSpec.describe "ambassadorships/edit", type: :view do
  before(:each) do
    @ambassadorship = assign(:ambassadorship, FactoryGirl.build_stubbed(:ambassadorship))
  end

  it "renders the edit ambassadorship form" do
    render

    assert_select "form[action=?][method=?]", ambassadorship_path(@ambassadorship), "post" do
    end
  end
end
