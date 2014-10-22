class MainController < ApplicationController
  def index
    @suggested = Game.filter(params.slice(:platform)).order("RANDOM()").paginate(page: params[:page], :per_page => 6)
    @games_to_try = Game.filter(params.slice(:platform)).order("RANDOM()").paginate(page: params[:page], :per_page => 18)
    @top_games = Game.order('score desc').limit(6)
    @filter = (params[:platform].nil?) ? "All" : params[:platform]
  end
end
