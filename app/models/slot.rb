class Slot < ApplicationRecord
  has_many :bookings, dependent: :destroy
  enum access_level: {general_access:0, vip_access:1, dr_access:2}
  enum power_switch: {power_on:0, power_off:1}

  TIME_LIST = {"08:00":0, "08:30":1, "09:00":2, "09:30":3, "10:00":4, "10:30":5, "11:00":6, "11:30":7,
    "12:00":8, "12:30":9, "13:00":10, "13:30":11, "14:00":12, "14:30":13, "15:00":14, "15:30":15,"16:00":16, "16:30":17}
  
  enum start_time: TIME_LIST
  enum end_time: TIME_LIST, _suffix: true

  validate :start_ealier_than_end

  def start_ealier_than_end
    errors.add(:start_time, "は終了時間よりも早く設定してください")if end_time <= start_time
  end

end
