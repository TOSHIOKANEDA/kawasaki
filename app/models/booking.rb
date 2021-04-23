class Booking < ApplicationRecord
  belongs_to :slot
  belongs_to :user

  enum off_action: {"空バン返却":0, "実入り搬入":1}
  enum on_action: {"実入りPICK":0, "空バンPICK":1}

  VALID_CNTR_REGEX = /\A^[A-Z]{3}[UJZ]{1}[0-9]{7}$\z/

  validates :cntr_booking, presence: true

  with_options format: { with: VALID_CNTR_REGEX, message: :invalid_cntr_num  } do
    validates :on_imp_laden_pick, if: -> { on_exp_booking_num.blank? }
    validates :off_imp_empty_return, if: -> { off_exp_laden_in.blank? }
    validates :off_exp_laden_in, if: -> { off_imp_empty_return.blank? }
  end
  
  #Error内容はconfig/locales/jp.ymlに記述

  def cntr_booking
    off_exp_laden_in.presence or off_imp_empty_return.presence
    on_imp_laden_pick.presence or on_exp_booking_num.presence
  end

  def random_string(length = 5)
    a = [('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
    random_string = (0...6).map { a[rand(a.length)] }.join
  end


end
