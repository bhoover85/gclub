class Game < ActiveRecord::Base
  include Filterable
  scope :year, -> (year) { where year: year }

  has_many :reverse_wishlists, foreign_key: "wished_id", 
                               class_name: "Wishlist",
                               dependent: :destroy
  has_many :wishers, through: :reverse_wishlists, source: :wisher
  
  validates :name, presence: true
  validates :year, presence: true
  validates :genre, presence: true
  validates :platform, presence: true
  validates :description, presence: true
end
