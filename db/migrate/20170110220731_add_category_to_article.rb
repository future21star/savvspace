class AddCategoryToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :article_category_id, :integer, index: true
  end
end
