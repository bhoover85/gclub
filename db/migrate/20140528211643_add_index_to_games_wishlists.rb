class AddIndexToGamesWishlists < ActiveRecord::Migration
  def change
    add_index :games_wishlists, :game_id
    add_index :games_wishlists, :wishlist_id
    add_index :games_wishlists, [:game_id, :wishlist_id], unique: true
  end
end
