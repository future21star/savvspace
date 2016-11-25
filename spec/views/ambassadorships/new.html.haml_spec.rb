require 'rails_helper'

RSpec.describe "ambassadorships/new", type: :view do
  before(:each) do
    assign(:ambassadorship, Ambassadorship.new())
  end

  it "renders new ambassadorship form" do
    render

    assert_select "form[action=?][method=?]", ambassadorships_path, "post" do
    end
  end
end
