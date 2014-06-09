class UsersController < ApplicationController
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @wished = @user.wished_games.paginate(page: params[:page])
    @owned = @user.owned_games.paginate(page: params[:page])
  end

  def wished_games
    @title = "Games I Want"
    @user = User.find(params[:id])
    @games = @user.wished_games.paginate(page: params[:page]).order(sort_column + ' ' + sort_direction)
    render 'users/wishlist'
  end

  def owned_games
    @title = "Games I Own"
    @user = User.find(params[:id])
    @games = @user.owned_games.paginate(page: params[:page]).order(sort_column + ' ' + sort_direction)
    render 'users/ownership'
  end

  private
    def sort_column
      Game.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end
end
