class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :slot, foreign_key: true
      t.string :booking_code, null: false
      t.string :imp_cntr_num, null: false
      t.string :exp_cntr_num, defalut: 0
      t.integer :off_action, null: false
      t.integer :on_action, null: false
      t.timestamps
    end
  end
end
