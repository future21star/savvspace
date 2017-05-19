class TrailblazersController < ApplicationController
  def index
    role = Role.find_or_create_by(name: 'trailblazer')
    @users = role.users.includes(:profile).distinct
  end
end
