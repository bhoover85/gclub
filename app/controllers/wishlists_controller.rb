class WishlistsController < ApplicationController
  before_action :authenticate_user!

  def create
    @game = User.find(params[:wishlist][:wished_id])
    current_user.add_to_wishlist!(@game)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    @game = Wishlist.find(params[:id]).wished
    current_user.remove_from_wishlist!(@game)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end