class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.integer :start_timestamp
      t.integer :end_timestamp
      t.integer :path_id
      t.integer :responsible_id
      t.integer :mentor_id
      t.boolean :is_canceled
      t.integer :canceled_id

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
