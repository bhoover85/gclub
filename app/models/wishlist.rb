class Wishlist < ActiveRecord::Base
  belongs_to :user
  has_many :wishes, foreign_key: "game_id", dependent: :destroy
end
