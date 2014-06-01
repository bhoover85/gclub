class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]

  # Wishlist relationship
  has_many :wishlists, foreign_key: "wisher_id", dependent: :destroy
  has_many :wished_games, through: :wishlists, source: :wished

  # Ownership (Library) relationship
  has_many :ownerships, foreign_key: "owner_id", dependent: :destroy
  has_many :owned_games, through: :ownerships, source: :owned

  def self.find_for_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  # Check if game is in user wishlist
  def wished?(game)
    wishlists.find_by(wished_id: game.id)
  end

  # Add game to wishlist
  def add_to_wishlist!(game)
    wishlists.create!(wished_id: game.id)
  end

  # Remove game from wishlist
  def remove_from_wishlist!(game)
    wishlists.find_by(wished_id: game.id).destroy
  end

  # Check if game is in user library
  def owned?(game)
    ownerships.find_by(owned_id: game.id)
  end

  # Add game to library
  def add_to_library!(game)
    ownerships.create!(owned_id: game.id)
  end

  # Remove game from library
  def remove_from_library!(game)
    ownerships.find_by(owned_id: game.id).destroy
  end
end
