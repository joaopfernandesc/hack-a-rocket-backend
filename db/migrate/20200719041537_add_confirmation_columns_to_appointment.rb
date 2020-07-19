class AddConfirmationColumnsToAppointment < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :responsible_confirmed, :boolean, :default => false
    add_column :appointments, :mentor_confirmed, :boolean, :default => false
    add_column :appointments, :send_timestamp, :integer
  end
end
