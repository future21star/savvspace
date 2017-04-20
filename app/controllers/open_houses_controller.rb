class OpenHousesController < ApplicationController
  before_action :authenticate_user!

  def new_property_email
    @property = OpenHouse.find(params[:open_house_id])
  end

  def send_property_email
    @property = OpenHouse.find(params[:open_house_id])
    OpenHouseMailer.single_property(current_user, @property).deliver_later

    render nothing: true
  end
end
