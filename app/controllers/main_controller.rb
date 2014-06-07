class MainController < ApplicationController
  def index
    @games = Game.filter(params.slice(:year)).order("RANDOM()").paginate(page: params[:page], :per_page => 10)
    @filter = (params[:year].nil?) ? "All Time" : params[:year]
  end
end
