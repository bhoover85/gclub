class RenameWishesToWishlist < ActiveRecord::Migration
  def change
    drop_table :wishlists
    rename_table :wishes, :wishlists
    rename_column :wishlists, :wishlist_id, :wisher_id
    rename_column :wishlists, :game_id, :wished_id
  end
end
