module SlotsHelper
  def available_num(slot)
    bookings_num = Booking.where(slot_id: slot.id).length
    num = slot.max_num - bookings_num
  end
end
