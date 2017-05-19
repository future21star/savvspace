class AuthorsController < ApplicationController
  def index
    role = Role.find_or_create_by(name: 'author')
    @users = role.users.includes(:profile).distinct
  end
end
