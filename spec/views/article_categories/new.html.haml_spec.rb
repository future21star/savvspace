require 'rails_helper'

RSpec.describe "article_categories/new", type: :view do
  before(:each) do
    assign(:article_category, ArticleCategory.new(
      :string => ""
    ))
  end

  it "renders new article_category form" do
    render

    assert_select "form[action=?][method=?]", article_categories_path, "post" do

      assert_select "input#article_category_string[name=?]", "article_category[string]"
    end
  end
end
