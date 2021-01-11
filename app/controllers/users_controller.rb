class UsersController < ApplicationController
  before_action :set_params, only: [:show, :index]

  def index
    @bookings = @user.bookings
  end

  def show
  end

  private

  def set_params
    @user = User.find(params[:id])
  end
end
