class AddAmazonInfoToGames < ActiveRecord::Migration
  def change
    add_column :games, :list_price, :float
    add_column :games, :lowest_price, :float
    add_column :games, :savings, :float
    add_column :games, :wishlist_url, :string
    add_column :games, :similar_products, :blob
  end
end
