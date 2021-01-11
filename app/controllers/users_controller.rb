class UsersController < ApplicationController
  before_action :set_params, only: [:show, :index]

  def index
    @bookings = Booking.where(user_id: @user.id)
  end

  def show
  end

  private

  def set_params
    @user = User.find(params[:id])
  end
end
