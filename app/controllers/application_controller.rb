class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :company, :phone, :authority, :certificate, :order_num])
  end

  def after_sign_in_path_for(resource)
    if current_user.authority_before_type_cast == 9
      admin_bookings_path
    else
      new_booking_path
    end
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
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

  def authorized_user(user_authority)
    redirect_to new_user_session_path unless user_authority == 9
  end
  
end
