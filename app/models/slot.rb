class Slot < ApplicationRecord
  has_many :bookings, dependent: :destroy
end
