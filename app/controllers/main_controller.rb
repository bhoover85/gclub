class MainController < ApplicationController
  def index
    @suggested        = Game.filter(params.slice(:platform)).order("RANDOM()").limit(6)
    @more_great_games = Game.filter(params.slice(:platform)).order("RANDOM()").limit(18)
    @top_games        = Game.order('score desc').limit(6)
    # @filter = (params[:platform].nil?) ? "All" : params[:platform]
  end
end
