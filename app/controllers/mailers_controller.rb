class MailersController < ApplicationController
  before_action :authenticate_user!

  protected

  def recepients
    mailer_params = params.require(:mailer).permit(:recepients, :include_sender)

    recepients = mailer_params[:recepients].split(',')
    recepients << current_user.email if mailer_params[:include_sender]

    recepients
  end
end
