class CreateSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :slots do |t|
      t.integer :max_num, null: false
      t.date :date, null: false
      t.integer :access_level, default: 0
      t.integer :power_switch, default: 0
      t.integer :full_status, default: 0
      t.string :start_time, null: false
      t.string :end_time, null: false
      t.timestamps
    end
  end
end
