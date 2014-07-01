class MainController < ApplicationController
  def index
    @games = Game.filter(params.slice(:platform)).order("RANDOM()").paginate(page: params[:page], :per_page => 5)
    @filter = (params[:platform].nil?) ? "All" : params[:platform]
  end
end
