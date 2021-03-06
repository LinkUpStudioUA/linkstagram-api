class ProfilesController < ApplicationController
  def index
    page = to_int(params[:page])
    page = 0 if Account.page(page).out_of_range?
    profiles = Account.ordered
    render json: AccountBlueprint.render(profiles.page(page)), status: 200
  end

  def show
    profile = Account.find_by_username(params[:username])
    render json: AccountBlueprint.render(profile), status: 200
  end
end
