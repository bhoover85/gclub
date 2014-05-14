class Game < ActiveRecord::Base
  validates :name, presence: true
  validates :year, presence: true
  validates :genre, presence: true
  validates :platform, presence: true
  validates :description, presence: true
end
