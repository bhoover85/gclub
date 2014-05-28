class GamesController < ApplicationController
  # before_action :authenticate_user!
  before_action :admin_user, only: [:new, :edit, :update, :destroy]

  def index
    @games = Game.paginate(page: params[:page])
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      flash[:success] = "New game added!"
      redirect_to @game
    else
      render 'new'
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(game_params)
      flash[:success] = "Game updated"
      redirect_to @game
    else
      render 'edit'
    end
  end

  def destroy
    Game.find(params[:id]).destroy
    flash[:success] = "Game deleted."
    redirect_to games_path
  end

  private

    def game_params
      params.require(:game).permit(:name, :year, :description, :genre, :platform)
    end
    
end
