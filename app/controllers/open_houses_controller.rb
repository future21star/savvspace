class OpenHousesController < ApplicationController
  before_action :authenticate_user!

  def new_property_email
    @property = OpenHouse.find(params[:open_house_id])
    @referrer_id = params[:referrer_id]
  end

  def send_property_email
    @property = OpenHouse.find(params[:open_house_id])
    @referrer = Profile.find_by(id: params[:referrer_id])
    OpenHouseMailer.single_property(current_user, @property, @referrer).deliver_later
  end
end
