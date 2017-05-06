class PropertyMailersController < ApplicationController
  before_action :authenticate_user!

  def new
    @referrer_id = params[:referrer_id]
    @property = Property.find(params[:property_id])
  end

  def create
    @referrer_id = params[:referrer_id]
    property_id = params[:property_id]

    PropertyMailer.send_single_property_request(current_user.id, @referrer_id, property_id, recepients)
  end

  private

  def recepients
    mailer_params = params.require(:property_mailer).permit(:recepients, :include_sender)

    recepients = mailer_params[:recepients].split(',')
    recepients << current_user.email if mailer_params[:include_sender]

    recepients
  end
end
