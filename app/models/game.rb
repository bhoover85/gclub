class Game < ActiveRecord::Base
  include GamesHelper
  include Filterable
  extend FriendlyId
  
  # Used to filter games by platform
  scope :platform, -> (platform) { where platform: platform }

  # Pretty URLs
  friendly_id :name_platform, use: :slugged

  def name_platform
    "#{name} #{platform}"
  end

  has_attached_file :cover, :styles => { :large => "196x276>", :medium => "147x207", :thumb => "98x138>", :xs => "49x69>" }, 
                    :default_url => "../assets/images/:style/missing.png",
                    :convert_options => {
                      :large => "-strip", :medium => "-strip", :thumb => "-strip", :xs => "-strip"
                    }
  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/

  # Wishlist
  has_many :reverse_wishlists, foreign_key: "wished_id", class_name: "Wishlist", dependent: :destroy
  has_many :wishers, through: :reverse_wishlists, source: :wisher

  # Ownership
  has_many :reverse_ownerships, foreign_key: "owned_id", class_name: "Ownership", dependent: :destroy
  has_many :owners, through: :reverse_ownerships, source: :owner
  
  # New record validation
  validates :name, presence: true
  validates :year, presence: true
  validates :platform, presence: true
  validates :description, presence: true

  # Used for schedule.rb cron job to update Metacritic score for all games
  serialize :critic_reviews, Array
  def self.update_metacritic_info
    @games = Game.all
    @games.each do |game|
      metacritic = GamesHelper.metacritic_info(game.name, game.platform)
      game.update_attributes(:score => metacritic.first['score'], :critic_reviews => metacritic.first['critic_reviews'])
    end
  end

  serialize :similar_products, Hash
  def self.update_amazon_info
    @games = Game.all
    @games.each do |game|
      if game.asin != "Error"
        amazon = GamesHelper.amazon_info(game.asin, "ItemAttributes, OfferSummary, Similarities")
        game.update_attributes(:list_price => amazon.first['list_price'], :lowest_price => amazon.first['lowest_price'], 
                               :savings => amazon.first['savings'], :page_url => amazon.first['page_url'], 
                               :wishlist_url => amazon.first['wishlist_url'], :similar_products => amazon.first['similar_products'])
      end
    end
  end
end
