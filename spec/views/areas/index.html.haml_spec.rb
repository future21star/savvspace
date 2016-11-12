require 'rails_helper'

RSpec.describe "areas/index", type: :view do
  before(:each) do
    assign(:areas, [
      Area.create!(
        :name => "Name"
      ),
      Area.create!(
        :name => "Name2"
      )
    ])
  end

  it "renders a list of areas" do
    render
    assert_select ".panel-title", :text => "Name".to_s, :count => 1
    assert_select ".panel-title", :text => "Name2".to_s, :count => 1
  end
end
