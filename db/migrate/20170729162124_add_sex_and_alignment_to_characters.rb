class AddSexAndAlignmentToCharacters < ActiveRecord::Migration[5.1]
  def change
    add_column :characters, :sex, :integer
    add_column :characters, :alignment, :integer
  end
end
