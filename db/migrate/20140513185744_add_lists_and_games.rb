class AddListsAndGames < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.timestamps
    end
 
    create_table :games do |t|
      t.string :name
      t.timestamps
    end
 
    create_table :lists_games, id: false do |t|
      t.belongs_to :list
      t.belongs_to :game
    end
  end
end
