class AddUserIdToWishlists < ActiveRecord::Migration
  def change
    add_column :wishlists, :user_id, :integer
    add_index :wishlists, :user_id
  end
end
