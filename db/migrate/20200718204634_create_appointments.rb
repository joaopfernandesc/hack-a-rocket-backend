class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.integer :start_timestamp
      t.integer :end_timestamp
      t.integer :path

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
