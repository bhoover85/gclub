class AddSlugsToGames < ActiveRecord::Migration
  def change
    add_column :games, :slug, :string, :unique => true
    add_index :games, :slug
  end
end
