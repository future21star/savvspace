class FavoritesMailersController < ApplicationController
  before_action :authenticate_user!

  def new
    @referrer_id = params[:referrer_id]
    @referrer_id = params[:item_type]
  end

  def create
    @referrer_id = params[:referrer_id]
    item_type = params[:item_type]
    FavoritesMailer.send_favorites_request(current_user.id, @referrer_id, recepients, item_type)
  end

  private

  def recepients
    mailer_params = params.require(:favorites_mailer).permit(:recepients, :include_sender)

    recepients = mailer_params[:recepients].split(',')
    recepients << current_user.email if mailer_params[:include_sender]

    recepients
  end
end
