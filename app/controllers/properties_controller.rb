class PropertiesController < ApplicationController
  before_action :authenticate_user!, except: :show

  def show
    @mls_server = MlsServer.find(params[:mls_server_id])
    @profile = Profile.find_by(id: params[:profile_id])
    @property = @mls_server.properties.find_by(internal_mls_id: params[:id]) ||
      Rails.cache.fetch("mls_property_#{@mls_server.id}_#{params[:id]}", expires_in: 1.hour) do
      @mls_server.fetch_property(params[:id])
    end
  end

  def new_property_email
    @property = Property.find(params[:property_id])
    @referrer_id = params[:referrer_id]
  end

  def send_property_email
    @property = Property.find(params[:property_id])
    @referrer = Profile.find_by(id: params[:referrer_id])
    PropertyMailer.single_property(current_user, @property, @referrer).deliver_later
  end

  def new_favorites_email
    @referrer_id = params[:referrer_id]
  end

  def send_favorites_email
    @referrer = Profile.find_by(id: params[:referrer_id])
    PropertyMailer.favorites(current_user, @referrer).deliver_later
  end
end
