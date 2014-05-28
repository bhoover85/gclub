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
    @wishlist = @user.wishlist
    render 'wishlist'
  end
end
