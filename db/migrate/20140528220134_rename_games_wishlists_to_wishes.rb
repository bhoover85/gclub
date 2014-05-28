class RenameGamesWishlistsToWishes < ActiveRecord::Migration
  def change
    rename_table :games_wishlists, :wishes

    change_table :wishes do |t|
      t.timestamps
    end
  end
end
