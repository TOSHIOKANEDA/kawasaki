class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :slot, foreign_key: true
      t.string :booking_code, null: false
      t.string :on_imp_laden_pick, defalut: 0
      t.string :on_exp_booking_num, defalut: 0
      t.string :off_exp_laden_in, defalut: 0
      t.string :off_imp_empty_return, defalut: 0
      t.integer :off_action, null: false
      t.integer :on_action, null: false
      t.timestamps
    end
  end
end
