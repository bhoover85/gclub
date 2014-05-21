class MainController < ApplicationController
  def index
    @games = Game.filter(params.slice(:year))
  end
end
