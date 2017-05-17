class FavoriteItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_favorite_item, only: %i[show edit update destroy]

  # GET /favorite_items
  # GET /favorite_items.json
  def index
    @favorite_items = FavoriteItem.all
  end

  # GET /favorite_items/1
  # GET /favorite_items/1.json
  def show; end

  # GET /favorite_items/new
  def new
    @favorite_item = FavoriteItem.new
  end

  # GET /favorite_items/1/edit
  def edit; end

  # POST /favorite_items
  # POST /favorite_items.json
  def create
    @favorite_item = current_user.favorite_items.new(favorite_item_params)

    respond_to do |format|
      if @favorite_item.save
        format.html { redirect_to @favorite_item, notice: t('.notice') }
        format.js
        format.json { render :show, status: :created, location: @favorite_item }
      else
        format.html { render :new }
        format.json { render json: @favorite_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /favorite_items/1
  # PATCH/PUT /favorite_items/1.json
  def update
    respond_to do |format|
      if @favorite_item.update(favorite_item_params)
        format.html { redirect_to @favorite_item, notice: t('.notice') }
        format.json { render :show, status: :ok, location: @favorite_item }
      else
        format.html { render :edit }
        format.json { render json: @favorite_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorite_items/1
  # DELETE /favorite_items/1.json
  def destroy
    @favorite_item.destroy
    respond_to do |format|
      format.html { redirect_to favorite_items_url, notice: t('.notice') }
      format.js
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_favorite_item
    @favorite_item = FavoriteItem.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def favorite_item_params
    params.require(:favorite_item).permit(:favorite_id, :favorite_type, :user_id)
  end
end
