module SlotsHelper
  def available_num(slot_id)
    bookings_num = Booking.where(slot_id: slot_id).length
    slot = Slot.find_by(id: slot_id)
    num = slot.max_num - bookings_num
  end

end
