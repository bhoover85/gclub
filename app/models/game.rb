class Game < ActiveRecord::Base
  include Filterable
  scope :year, -> (year) { where year: year }

  has_many :wishlists
  
  validates :name, presence: true
  validates :year, presence: true
  validates :genre, presence: true
  validates :platform, presence: true
  validates :description, presence: true
end
