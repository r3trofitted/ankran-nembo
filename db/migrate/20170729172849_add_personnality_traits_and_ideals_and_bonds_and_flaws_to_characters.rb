class AddPersonnalityTraitsAndIdealsAndBondsAndFlawsToCharacters < ActiveRecord::Migration[5.1]
  def change
    add_column :characters, :personnality_traits, :string, array: true, default: []
    add_column :characters, :ideals, :string, array: true, default: []
    add_column :characters, :bonds, :string, array: true, default: []
    add_column :characters, :flaws, :string, array: true, default: []
  end
end
