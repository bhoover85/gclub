class AddAsinToGames < ActiveRecord::Migration
  def change
    add_column :games, :asin, :string
  end
end
