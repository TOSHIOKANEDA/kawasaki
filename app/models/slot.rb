class Slot < ApplicationRecord
  has_many :bookings, dependent: :destroy
  enum access_level: {general_access:0, vip_access:1, dr_access:2}
  enum power_switch: {power_on:0, power_off:1}

end
