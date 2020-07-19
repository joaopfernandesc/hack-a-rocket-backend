class CreatePaths < ActiveRecord::Migration[6.0]
  def change
    create_table :paths do |t|
      t.string :name

      t.timestamps
    end
  end

  names = ["Jurídico", "Negócios", "Marketing", "Finanças", "Tecnologia", "Inovação", "Mídias Digitais"]
  starting_paths = names.map! { |x| {name: x}}

  Path.create()
end
