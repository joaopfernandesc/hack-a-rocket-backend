class CreateRegularTimes < ActiveRecord::Migration[6.0]
  def change
    create_table :regular_times do |t|
      t.integer :weekday
      t.integer :start_time
      t.integer :end_time
      t.integer :user_id

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
