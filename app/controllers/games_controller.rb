class GamesController < ApplicationController
  before_action :authenticate_user!
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

  private

    def game_params
      params.require(:game).permit(:name, :year, :description, :genre, :platform)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
