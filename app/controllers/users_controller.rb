class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def wished_games
    @title = "Wishlist"
    @user = User.find(params[:id])
    @games = @user.wished_games.paginate(page: params[:page])
    render 'users/wishlist'
  end

  def owned_games
    @title = "Library"
    @user = User.find(params[:id])
    @games = @user.owned_games.paginate(page: params[:page])
    render 'users/ownership'
  end
end
