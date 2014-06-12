class AddAmazonPageUrlToGames < ActiveRecord::Migration
  def change
    add_column :games, :page_url, :string
  end
end
