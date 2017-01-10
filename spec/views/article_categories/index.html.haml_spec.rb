require 'rails_helper'

RSpec.describe "article_categories/index", type: :view do
  before(:each) do
    assign(:article_categories, [
      ArticleCategory.create!(
        :string => ""
      ),
      ArticleCategory.create!(
        :string => ""
      )
    ])
  end

  it "renders a list of article_categories" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
