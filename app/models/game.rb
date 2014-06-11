class Game < ActiveRecord::Base
  include Filterable
  scope :year, -> (year) { where year: year }

  extend FriendlyId
  friendly_id :name_platform, use: :slugged

  def name_platform
    "#{name} #{platform}"
  end

  has_attached_file :cover, :styles => { :medium => "196x276>", :thumb => "98x138>", :xs => "49x69>" }, :default_url => "../assets/images/:style/missing.png"
  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/

  # Wishlist
  has_many :reverse_wishlists, foreign_key: "wished_id", class_name: "Wishlist", dependent: :destroy
  has_many :wishers, through: :reverse_wishlists, source: :wisher

  # Ownership
  has_many :reverse_ownerships, foreign_key: "owned_id", class_name: "Ownership", dependent: :destroy
  has_many :owners, through: :reverse_ownerships, source: :owner
  
  validates :name, presence: true
  validates :year, presence: true
  validates :platform, presence: true
  validates :description, presence: true
end
