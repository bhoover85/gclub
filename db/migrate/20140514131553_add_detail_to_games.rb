class AddDetailToGames < ActiveRecord::Migration
  def change
    add_column :games, :year,         :integer
    add_column :games, :description,  :text
    add_column :games, :genre,        :string

    add_index :games, :year
    add_index :games, :genre
  end
end
