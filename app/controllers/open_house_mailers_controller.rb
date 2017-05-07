class OpenHouseMailersController < MailersController

  def new
    @referrer_id = params[:referrer_id]
    @open_house_id = params[:open_house_id]
  end

  def create
    referrer_id = params[:referrer_id]
    item_id = params[:open_house_id]

    SingleItemMailer.send_item_request(current_user.id, referrer_id, recepients, item_id, 'OpenHouse')
  end

end
