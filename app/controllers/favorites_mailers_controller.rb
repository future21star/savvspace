class FavoritesMailersController < MailersController

  def new
    @referrer_id = params[:referrer_id]
    @item_type = params[:item_type]
  end

  def create
    referrer_id = params[:referrer_id] || current_user.profile.id
    item_type = params[:item_type]

    FavoritesMailer.send_favorites_request(current_user.id, referrer_id, recepients, item_type)
  end

end
