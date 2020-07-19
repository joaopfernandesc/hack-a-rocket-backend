class AddWarningPendingColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :warning_pending, :boolean
  end
end
