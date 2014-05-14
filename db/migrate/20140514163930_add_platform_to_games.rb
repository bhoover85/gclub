class AddPlatformToGames < ActiveRecord::Migration
  def change
    add_column :games, :platform, :string
    add_index :games, :platform
  end
end
