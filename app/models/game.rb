class Game < ActiveRecord::Base
  include Filterable
  scope :year, -> (year) { where year: year }

  # Wishlist
  has_many :reverse_wishlists, foreign_key: "wished_id", 
                               class_name: "Wishlist",
                               dependent: :destroy
  has_many :wishers, through: :reverse_wishlists, source: :wisher

  # Ownership (Library)
  has_many :reverse_ownerships, foreign_key: "owned_id", 
                                class_name: "Ownership",
                                dependent: :destroy
  has_many :owners, through: :reverse_ownerships, source: :owner
  
  validates :name, presence: true
  validates :year, presence: true
  validates :genre, presence: true
  validates :platform, presence: true
  validates :description, presence: true
end
