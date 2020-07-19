class InitPaths < ActiveRecord::Migration[6.0]
  def up
    names = ["Jurídico", "Negócios", "Marketing", "Finanças", "Tecnologia", "Inovação", "Mídias Digitais"]
    starting_paths = names.map! { |x| {name: x}}
  
    Path.create(starting_paths)
  end
end
