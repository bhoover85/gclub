class AddCoverToGames < ActiveRecord::Migration
  def change
    add_attachment :games, :cover
  end
end
