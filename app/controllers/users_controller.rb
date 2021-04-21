class UsersController < ApplicationController
  before_action :set_params, only: [:update, :edit, :destroy]
  before_action :authenticate_user!

  def index
    # User登録一覧を表示
    authorized_user(current_user.authority_before_type_cast)
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
    authorized_user(current_user.authority_before_type_cast)
    if @user.delete
      redirect_to admin_bookings_path
    else
      p "失敗"
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
