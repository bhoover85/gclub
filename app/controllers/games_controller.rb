class GamesController < ApplicationController
  # before_action :authenticate_user!
  before_action :admin_user, only: [:new, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @games = Game.paginate(page: params[:page], :per_page => 50).order(sort_column + ' ' + sort_direction)
  end

  def show
    @game = Game.friendly.find(params[:id])
    @wishers = @game.wishers.order("RANDOM()").paginate(page: params[:page], :per_page => 52)
    @owners = @game.owners.order("RANDOM()").paginate(page: params[:page], :per_page => 52)
  end

  def wishers
    @game = Game.friendly.find(params[:id])
    @users = @game.wishers.paginate(page: params[:page])
    @title = "#{@game.name} Is Wanted By"
    render 'games/wishers'
  end

  def owners
    @game = Game.friendly.find(params[:id])
    @users = @game.owners.paginate(page: params[:page])
    @title = "#{@game.name} Is Owned By"
    render 'games/owners'
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    metacritic = GamesHelper.metacritic_info(@game.name, @game.platform)
    @game.asin = GamesHelper.get_asin(@game.name, @game.platform)
    @game.score = metacritic.first['score']
    @game.rlsdate = metacritic.first['rlsdate']
    @game.publisher = metacritic.first['publisher']
    @game.developer = metacritic.first['developer']
    @game.genre = metacritic.first['genre']

    if @game.save
      flash[:success] = "New game added!"
      redirect_to @game
    else
      render 'new'
    end
  end

  def edit
    @game = Game.friendly.find(params[:id])
  end

  def update
    @game = Game.friendly.find(params[:id])
    metacritic = GamesHelper.metacritic_info(@game.name, @game.platform)
    @game.asin = GamesHelper.get_asin(@game.name, @game.platform)
    @game.score = metacritic.first['score']
    @game.rlsdate = metacritic.first['rlsdate']
    @game.publisher = metacritic.first['publisher']
    @game.developer = metacritic.first['developer']
    @game.genre = metacritic.first['genre']
    
    if @game.update_attributes(game_params)
      flash[:success] = "Game updated"
      redirect_to @game
    else
      render 'edit'
    end
  end

  def destroy
    Game.friendly.find(params[:id]).destroy
    flash[:success] = "Game deleted"
    redirect_to games_path
  end

  private

    def game_params
      params.require(:game).permit(:name, :year, :description, :platform, :cover)
    end
    
end
