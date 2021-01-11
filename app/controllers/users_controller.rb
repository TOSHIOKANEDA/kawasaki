class UsersController < ApplicationController
  before_action :set_params, only: [:show, :index, :update]

  def index
    @bookings = Booking.where(user_id: @user.id)
  end

  def show
  end

  def update
    if @user.update(user_params)
      p 'OK'
      redirect_to user_path(id: current_user.id) 
    else
      p '失敗'
    end
  end

  private

  def set_params
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :company, :phone, :email)
  end
end
