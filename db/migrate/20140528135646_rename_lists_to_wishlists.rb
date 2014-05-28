class RenameListsToWishlists < ActiveRecord::Migration
  def change
    rename_table :lists, :wishlists
    rename_table :lists_games, :wishlists_games
    rename_column :wishlists_games, :list_id, :wishlist_id
  end
end
