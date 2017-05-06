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

end
