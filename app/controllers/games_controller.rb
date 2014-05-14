class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, only: [:new, :edit, :update, :destroy]

  def index
    @games = Game.paginate(page: params[:page])
  end

  def new
    @game = Game.new
  end

  private

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
