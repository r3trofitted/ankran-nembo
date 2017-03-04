class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :race
      t.string :character_class
      t.integer :level
      t.integer :strength
      t.integer :dexterity
      t.integer :constitution
      t.integer :intelligence
      t.integer :wisdom
      t.integer :charisma
      t.string :proficiencies, array: true
      t.string :languages, array: true
      t.text :armor
      t.text :shield

      t.timestamps
    end
  
    add_index :characters, :proficiencies, using: 'gin'
    add_index :characters, :languages, using: 'gin'
  end
end
