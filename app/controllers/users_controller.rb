class UsersController < ApplicationController
  before_action :find_params, only: [:update, :edit, :destroy, :show]
  before_action :authenticate_user!
  before_action :authorizer, only: [:index, :destroy]
  before_action :identifier, only: [:show, :edit, :update]

  def index
    # User登録一覧を表示
    @normal_users = User.where(authority: 0)
    @vip_users = User.where(authority: 1)
    @dr_users = User.where(authority: 2)
  end

  def show
  end

  def edit
  end

  def update
    unless current_user.authority_before_type_cast == 9
      if @user.update(user_params)
        p 'OK'
        redirect_to user_path(id: current_user.id) 
        flash[:notice] = "ユーザー登録変更をしました"
      else
        flash[:alert] = "ユーザー登録の変更に失敗しました"
      end
    else
      if @user.update(authorizing_control_params)
        redirect_to users_path
        flash[:notice] = "ユーザー登録変更をしました(管理者)"
      else
        flash[:alert] = "ユーザー登録の変更に失敗しました(管理者)"
      end
    end
  end

  def destroy
    Booking.where(user_id: @user.id).destroy_all
    if @user.delete
      redirect_to admin_bookings_path
      flash[:notice] = "ユーザー登録を削除しました(管理者)"
    else
      flash[:alert] = "ユーザー登録削除に失敗しました(管理者)"
    end
  end

  private

  def find_params
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :company, :phone, :email)
  end

  def authorizing_control_params
    params.require(:user).permit(:name, :company, :phone, :email, :authority)
  end

  def authorizer
    authorized_user(current_user.authority_before_type_cast)
  end

  def identifier
    find_params
    identical_user(@user.id) unless current_user.authority_before_type_cast == 9
  end


end
