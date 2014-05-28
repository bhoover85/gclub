class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def wishlist
    @user = User.find(params[:id])
    @wishlist = Wishlist.find_or_create_by(user_id: current_user.id)
    @wishlist = @user.wishlist
    render 'users/wishlist'
  end
end
