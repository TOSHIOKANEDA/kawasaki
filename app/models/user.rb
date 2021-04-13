class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum authority: {"一般":0, "特別":1, "管理者":9}
end
