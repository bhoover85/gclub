class MainController < ApplicationController
  def index
    @top_games        = Game.order('score desc').limit(12)
    @more_great_games = Game.order("RANDOM()").limit(18)
    # @filter = (params[:platform].nil?) ? "All" : params[:platform]
  end
end
