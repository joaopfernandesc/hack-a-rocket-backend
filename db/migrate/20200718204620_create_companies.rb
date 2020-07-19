class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :CNPJ
      t.string :category
      t.integer :user_id

      t.timestamps
    end
  end
end
