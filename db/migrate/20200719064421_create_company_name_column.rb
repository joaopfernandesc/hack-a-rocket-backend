class CreateCompanyNameColumn < ActiveRecord::Migration[6.0]
  def change
    create_table :company_name_columns do |t|
      add_column :companies, :company_name, :string
    end
  end
end
