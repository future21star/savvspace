class OpenHouseMailersController < ApplicationController
  before_action :authenticate_user!

  def new
    @referrer_id = params[:referrer_id]
    @open_house_id = params[:open_house_id]
  end

  def create
    @referrer_id = params[:referrer_id]
    item_id = params[:open_house_id]

    SingleItemMailer.send_item_request(current_user.id, @referrer_id, recepients, item_id, 'OpenHouse')
  end

  private

  def recepients
    mailer_params = params.require(:open_house_mailer).permit(:recepients, :include_sender)

    recepients = mailer_params[:recepients].split(',')
    recepients << current_user.email if mailer_params[:include_sender]

    recepients
  end
end
