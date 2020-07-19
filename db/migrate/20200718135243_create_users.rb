class CreateUser < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :phone_number
      t.boolean :is_confirmed
      t.string :confirmation_number
      t.integer :user_type
      t.integer :total_ratings
      t.float :average_rating
      t.string :CEP
      t.string :CPF

      t.timestamps
    end
  end
end
