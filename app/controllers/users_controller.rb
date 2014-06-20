class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, only: [:index]
  helper_method :sort_column, :sort_direction

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @wished = @user.wanted.paginate(page: params[:page]).sort_by &:name
    @owned = @user.owned.paginate(page: params[:page]).sort_by &:name
  end

  def wanted
    @title = "Games I Want"
    @user = User.find(params[:id])
    @games = @user.wanted.paginate(page: params[:page]).order(sort_column + ' ' + sort_direction)
    render 'users/wishlist'
  end

  def owned
    @title = "Games I Own"
    @user = User.find(params[:id])
    @games = @user.owned.paginate(page: params[:page]).order(sort_column + ' ' + sort_direction)
    render 'users/ownership'
  end
end
