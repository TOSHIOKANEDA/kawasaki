class BookingsController < ApplicationController
  before_action :set_params, only: [:confirm, :create]

  def index
  end

  def new
    @booking = Booking.new
  end

  def confirm
    render :new if @booking.invalid?
  end

  def create
    @booking.booking_code = @booking.random_string
    if params[:back]
      p "OK！"
      render :new
    elsif @booking.save
      redirect_to booking_path(@booking.id)
    else
      p "エラー！"
      render :new
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    params.require(:booking).permit(:imp_cntr_num, :exp_cntr_num, :off_action, :on_action, :slot_id).merge(user_id: current_user.id)
  end

  def set_params
    @booking = Booking.new(booking_params)
  end
end
