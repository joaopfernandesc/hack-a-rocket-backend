class CreateConsultants < ActiveRecord::Migration[6.0]
  def change
    create_table :consultants do |t|
      t.integer :user_id
      t.string :college_name
      t.integer :experience_years
      t.string :website
      t.string :graduation_course
      t.string :description, limit: 500

      t.timestamps
    end
  end
end
