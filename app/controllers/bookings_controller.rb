class BookingsController < ApplicationController
  before_action :set_params, only: [:confirm, :create]
  before_action :find_params, only: [:edit, :show, :update, :destroy]
  before_action :find_available_slots, only: [:new, :create, :edit]
  before_action :authenticate_user!
  before_action :authorizer, only: [:admin, :booking_down_load]
  before_action :identifier, only: [:edit, :update, :destroy, :show]

  def admin
  end

  def booking_down_load
    @bookings = Booking.all
    @slots = Slot.all
    if @bookings.present?
      respond_to do |format|
      format.xlsx{
        response.headers["Content-Disposition"] = 'attachment; filename="予約一覧.xlsx"'
      }
      end
    else
      redirect_to admin_bookings_path
      flash[:alert] = "予約はゼロ件です"
    end
  end

  def index
    @bookings = Booking.where(user_id: current_user.id)
  end

  def destroy
    if @booking.delete
      update_full_status(@booking.slot_id)
      redirect_to root_path
      flash[:notice] = "予約を削除しました"
    else
      flash[:alert] = "エラーにより削除できませんでした"
    end
  end

  def new
    @booking = Booking.new
  end

  def full
  end

  def confirm
    if @booking.invalid?
      redirect_to new_booking_path
      @booking.errors.full_messages.each_with_index do |msg, index|
        flash[:alert] = msg
      end
    end
  end

  def create
    @booking.booking_code = @booking.random_string
    if params[:back]
      flash[:notice] = "戻りました"
      redirect_to new_booking_path
    elsif @booking.slot.full_status == 0
      @booking.save
      update_full_status(@booking.slot_id)
      redirect_to booking_path(@booking.id)
      flash[:notice] = "予約完了しました"
    else
      redirect_to new_booking_path
      flash[:alert] = "エラーにより保存できませんでした"
    end
  end

  def show
  end

  def update
    if @booking.update(update_params)
      flash[:notice] = "変更完了しました"
      redirect_to booking_path(id: @booking.id) 
    else
      flash[:alert] = "エラーにより変更できませんでした"
    end
  end

  def edit
  end

  private

  def booking_params
    params.require(:booking).permit(:on_imp_laden_pick, :on_exp_booking_num, :off_exp_laden_in, :off_action, :off_imp_empty_return, :on_action, :slot_id).merge(user_id: current_user.id)
  end

  def update_params
    booking_params.merge(booking_code: @booking.booking_code)
  end

  def set_params
    @booking = Booking.new(booking_params)
  end

  def find_params
    @booking = Booking.find(params[:id])
  end

  def find_available_slots
    #booking.helper内が空かどうかで分岐
    if current_user.authority_before_type_cast == 1
      redirect_to full_bookings_path unless view_context.vip.present?
    elsif current_user.authority_before_type_cast == 2
      redirect_to full_bookings_path unless view_context.dr.present?
    elsif current_user.authority_before_type_cast == 0
      redirect_to full_bookings_path unless view_context.normal.present?
    end
  end

  def authorizer
    authorized_user(current_user.authority_before_type_cast)
  end

  def identifier
    find_params
    identical_user(@booking.user_id) unless current_user.authority_before_type_cast == 9
  end


end
