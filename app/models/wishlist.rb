class Wishlist < ActiveRecord::Base
  belongs_to :wisher, class_name: "User"
  belongs_to :wished, class_name: "Game"
end
