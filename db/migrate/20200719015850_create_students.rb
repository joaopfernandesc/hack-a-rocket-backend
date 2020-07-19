class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.integer :user_id
      t.string :college_name
      t.string :current_semester
      t.string :registration_number
      t.string :graduation_course
      t.string :description, limit: 500

      t.timestamps
    end
  end
end
