class AddPrimaryKeyToWishlists < ActiveRecord::Migration
  def change
    add_column :wishlists, :id, :primary_key
  end
end
