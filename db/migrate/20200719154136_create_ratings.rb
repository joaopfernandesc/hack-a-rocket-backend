class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.string :description, limit: 500
      t.integer :to_id
      t.integer :from_id
      t.integer :appointment_id
      t.integer :rating

      t.timestamps
    end
  end
end
