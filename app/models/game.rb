class Game < ActiveRecord::Base
  include Filterable
  scope :year, -> (year) { where year: year }

  has_and_belongs_to_many :wishlists
  
  validates :name, presence: true
  validates :year, presence: true
  validates :genre, presence: true
  validates :platform, presence: true
  validates :description, presence: true
end
