class Booking < ApplicationRecord
  belongs_to :slot
  belongs_to :user

  enum off_action: {"空バン返却":0, "実入り搬入":1}
  enum on_action: {"実入りPICK":0, "空バンPICK":1}

  def random_string(length = 5)
    a = [('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
    random_string = (0...6).map { a[rand(a.length)] }.join
  end

end
