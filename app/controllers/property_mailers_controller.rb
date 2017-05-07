class PropertyMailersController < MailersController

  def new
    @referrer_id = params[:referrer_id]
    @property_id = params[:property_id]
  end

  def create
    referrer_id = params[:referrer_id] || current_user.profile.id
    item_id = params[:property_id]

    SingleItemMailer.send_item_request(current_user.id, referrer_id, recepients, item_id, 'Property')
  end

end
