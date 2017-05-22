class AuthorizationsController < ApplicationController
  before_action :require_admin

  def create
    user = User.find(params[:user_id])
    role_name =  params[:role_name]

    respond_to do |format|
      if user.grant_role(role_name)
        format.html { redirect_to users_path }
        format.js
        format.json { render :show, status: :created, location: @authorization }
      else
        format.html { render :new }
        format.json { render json: @authorization.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    user = User.find(params[:user_id])
    role_name =  params[:role_name]

    user.remove_role(role_name)

    respond_to do |format|
      format.html { redirect_to users_path }
      format.js
      format.json { head :no_content }
    end
  end

end
