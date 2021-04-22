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
      p "Bookingはありません"
    end
  end

  def index
    @bookings = Booking.where(user_id: current_user.id)
  end

  def destroy
    if @booking.delete
      update_full_status(@booking.slot_id)
      redirect_to root_path
    else
      p "失敗"
    end
  end

  def new
    @booking = Booking.new
    @imp_val = ""
    @exp_cntr_val = ""
    @exp_booking_val = ""
  end

  def full
  end

  def confirm
    if @booking.invalid?
    redirect_to new_booking_path flash: { error: @booking.errors.full_messages }
    end
  end

  def create
    @booking.booking_code = @booking.random_string
    if params[:back]
      p "OK！"
      redirect_to new_booking_path
    elsif @booking.slot.full_status == 0
      @booking.save
      update_full_status(@booking.slot_id)
      redirect_to booking_path(@booking.id)
    else
      p "エラー！"
      redirect_to new_booking_path
    end
  end

  def show
  end

  def update
    if @booking.update(update_params)
      p 'OK'
      redirect_to booking_path(id: @booking.id) 
    else
      p '失敗'
    end
  end

  def edit
    @imp_val = @booking.imp_cntr_num
    @exp_cntr_val = @booking.exp_cntr_num
    @exp_booking_val = @booking.exp_booking_num
  end

  private

  def booking_params
    params.require(:booking).permit(:exp_booking_num, :imp_cntr_num, :exp_cntr_num, :off_action, :on_action, :slot_id).merge(user_id: current_user.id)
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
    @slots = Slot.where(full_status: 0)
    unless @slots.present?
      redirect_to full_bookings_path
      p "もう予約できる枠がありません"
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
