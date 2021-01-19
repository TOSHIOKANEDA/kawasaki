class BookingsController < ApplicationController
  before_action :set_params, only: [:confirm, :create]
  before_action :find_params, only: [:edit, :show, :update]

  def index
  end

  def new
    @booking = Booking.new
    @imp_val = ""
    @exp_val = ""
  end

  def confirm
    render :new if @booking.invalid?
  end

  def create
    @booking.booking_code = @booking.random_string
    @booking.check_full_status
    if params[:back]
      p "OK！"
      render :new
    elsif @booking.check_full_status == 1
      @booking.save
      redirect_to booking_path(@booking.id)
    else
      p "エラー！"
      render :new
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
    @exp_val = @booking.exp_cntr_num
  end

  private

  def booking_params
    params.require(:booking).permit(:imp_cntr_num, :exp_cntr_num, :off_action, :on_action, :slot_id).merge(user_id: current_user.id)
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
end
