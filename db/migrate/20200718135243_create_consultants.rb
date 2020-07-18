class CreateConsultants < ActiveRecord::Migration[6.0]
  def change
    create_table :consultants do |t|
      t.string :first_name
      t.string :last_name
      t.string :website

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
