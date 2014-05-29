class WishlistsController < ApplicationController
  before_action :signed_in_user

  def create
    @user = User.find(params[:wishlist][:wished_id])
    current_user.follow!(@game)
    respond_to do |format|
      format.html { redirect_to @game }
      format.js
    end
  end

  def destroy
    @user = Wishlist.find(params[:id]).wished
    current_user.unfollow!(@game)
    respond_to do |format|
      format.html { redirect_to @game }
      format.js
    end
  end
end