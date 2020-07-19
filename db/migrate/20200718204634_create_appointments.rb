class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
