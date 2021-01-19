class Slot < ApplicationRecord
  has_many :bookings, dependent: :destroy

  enum access_level: {"一般権限":0, "VIP権限":1, "ラウンド権限":2}
  enum power_switch: {"表示ON":0, "表示OFF":1}
  enum slot_purpose: {"08:00から10:00":0, "10:00から12:00":1}

end
