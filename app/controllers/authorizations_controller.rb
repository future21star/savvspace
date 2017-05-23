class AuthorizationsController < ApplicationController
  before_action :require_admin
  before_action :set_user

  def create
    respond_to do |format|
      if @user.grant_role!(role_name)
        format.html { redirect_to users_path }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.remove_role(role_name)
        format.html { redirect_to users_path }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def role_name
    params[:role_name]
  end
end
