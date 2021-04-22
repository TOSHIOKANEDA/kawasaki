class UsersController < ApplicationController
  before_action :find_params, only: [:update, :edit, :destroy, :show]
  before_action :authenticate_user!
  before_action :authorizer, only: [:index, :destroy]
  before_action :identifier, only: [:show, :edit, :update]

  def index
    # User登録一覧を表示
    @normal_users = User.where(authority: 0)
    @special_users = User.where(authority: 1)
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      p 'OK'
      redirect_to user_path(id: current_user.id) 
    else
      p '失敗'
    end
  end

  def destroy
    Booking.where(user_id: @user.id).destroy_all
    if @user.delete
      redirect_to admin_bookings_path
    else
      p "失敗"
    end
  end

  private

  def find_params
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :company, :phone, :email)
  end

  def authorizer
    authorized_user(current_user.authority_before_type_cast)
  end

  def identifier
    find_params
    identical_user(@user.id) unless current_user.authority_before_type_cast == 9
  end


end
