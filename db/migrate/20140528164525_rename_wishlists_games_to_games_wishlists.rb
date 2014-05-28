class RenameWishlistsGamesToGamesWishlists < ActiveRecord::Migration
  def change
    rename_table :wishlists_games, :games_wishlists
  end
end
