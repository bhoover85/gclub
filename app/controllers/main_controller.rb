class MainController < ApplicationController
  def index
    @games = Game.filter(params.slice(:year)).order("RANDOM()").limit(5)
    @filter = (params[:year].nil?) ? "All Time" : params[:year]
  end
end
