require 'rails_helper'

RSpec.describe "areas/index", type: :view do
  before(:each) do
    assign(:areas, [
      Area.create!(
        :name => "Name"
      ),
      Area.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of areas" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
