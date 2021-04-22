class Booking < ApplicationRecord
  belongs_to :slot
  belongs_to :user

  enum off_action: {"空バン返却":0, "実入り搬入":1}
  enum on_action: {"実入りPICK":0, "空バンPICK":1}

  VALID_CNTR_REGEX = /\A^[A-Z]{3}[UJZ]{1}[0-9]{7}$\z/

  validates :imp_cntr_num, presence: true,
  format: { with: VALID_CNTR_REGEX, message: :invalid_cntr_num  }

  validates :cntr_booking, presence: true
  validates :exp_cntr_num, if: -> { exp_booking_num.blank? },
  format: { with: VALID_CNTR_REGEX, message: :invalid_cntr_num  }

  #Error内容はconfig/locales/jp.ymlに記述

  def random_string(length = 5)
    a = [('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
    random_string = (0...6).map { a[rand(a.length)] }.join
  end

  def cntr_booking
    exp_booking_num.presence or exp_cntr_num.presence
  end

  

end
