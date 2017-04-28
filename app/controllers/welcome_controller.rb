class WelcomeController < ApplicationController
  layout 'marketing', only: :index

  def index
    @feature_article = Article.order(:created_at).first
  end

  def about
  end

  def contact
  end
end
