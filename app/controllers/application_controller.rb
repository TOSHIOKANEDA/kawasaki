class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :company, :phone, :authority, :certificate, :order_num])
  end

  def update_full_status(id)
    slot = Slot.find(id)
    bookings = Booking.where(slot_id: slot)
    if slot.max_num - bookings.length <= 0
      slot.update(full_status: 1)
    elsif slot.max_num - bookings.length > 0
      slot.update(full_status: 0)
    end
  end
  
end
