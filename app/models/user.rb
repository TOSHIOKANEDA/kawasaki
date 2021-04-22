class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  
  # Include default devise modules. Others available are:
  #:lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable

  enum authority: {"一般":0, "特別":1, "管理者":9}

  def phone=(value)
    if value.is_a?(String) || value.include?("ー") || value.include?("-") 
    value.tr!('０-９', '0-9')
    value.gsub!(/-/,'')
    value.gsub!(/ー/,'')
    end
    super(value)
  end
end
