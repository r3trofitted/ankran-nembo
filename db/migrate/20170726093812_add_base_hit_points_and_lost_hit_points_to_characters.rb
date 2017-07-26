class AddBaseHitPointsAndLostHitPointsToCharacters < ActiveRecord::Migration[5.1]
  def change
    add_column :characters, :base_hit_points, :integer
    add_column :characters, :lost_hit_points, :integer, default: 0, null: false
  end
end
