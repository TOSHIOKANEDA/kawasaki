class BookingsController < ApplicationController
  def index
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
  end
end
