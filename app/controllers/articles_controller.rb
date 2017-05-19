class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  # GET /articles
  # GET /articles.json
  def index
    scope = if params[:article_category_id]
              Article.where(article_category_id: params[:article_category_id])
            elsif params[:author_id]
              Article.where(user_id: params[:author_id])
            else
              Article.all
            end
    @articles = scope.order(updated_at: :desc)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    authorize @article
  end

  # GET /articles/new
  def new
    @article = Article.new
    authorize @article
  end

  # GET /articles/1/edit
  def edit
    authorize @article
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    authorize @article
    @article.author = current_user

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: t('.notice') }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    authorize @article

    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: t('.notice') }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    authorize @article
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: t('.notice') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:title, :body, :area_id, :article_category_id,
                                    :feature_photo, :secondary_photo, :tertiary_photo,
                                    :user_id, :video)
  end
end
