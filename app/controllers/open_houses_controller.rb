class OpenHousesController < ApplicationController
  before_action :authenticate_user!

  def new_property_email
    @referrer_id = params[:referrer_id]
    @property = OpenHouse.find(params[:open_house_id])
  end

  def send_property_email
    @referrer = Profile.find_by(id: params[:referrer_id])
    @property = OpenHouse.find(params[:open_house_id])

    OpenHouseMailer.single_property(current_user, @property, @referrer).deliver_later
  end

  def new_favorites_email
    @referrer_id = params[:referrer_id]
  end

  def send_favorites_email
    @referrer = Profile.find_by(id: params[:referrer_id])
    OpenHouseMailer.favorites(current_user, @referrer).deliver_later
  end
end
