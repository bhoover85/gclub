class AddMetacriticReviewsToGames < ActiveRecord::Migration
  def change
    add_column :games, :critic_reviews, :blob
  end
end
