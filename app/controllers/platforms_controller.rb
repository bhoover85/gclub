class PlatformsController < ApplicationController
  def index
  end

  def threeds
    @title = "Great 3DS Games"
    @games = Game.where(:platform => '3DS').order('name ASC')
  end

  def gamecube
    @title = "Great Gamecube Games"
    @games = Game.where(:platform => 'Gamecube').order('name ASC')
  end

  def pc
    @title = "Great PC Games"
    @games = Game.where(:platform => 'PC').order('name ASC')
  end

  def playstation_2
    @title = "Great Playstation 2 Games"
    @games = Game.where(:platform => 'Playstation 2').order('name ASC')
  end

  def playstation_3
    @title = "Great Playstation 3 Games"
    @games = Game.where(:platform => 'Playstation 3').order('name ASC')
  end

  def playstation_4
    @title = "Great Playstation 4 Games"
    @games = Game.where(:platform => 'Playstation 4').order('name ASC')
  end

  def wii
    @title = "Great Wii Games"
    @games = Game.where(:platform => 'Wii').order('name ASC')
  end

  def wii_u
    @title = "Great Wii U Games"
    @games = Game.where(:platform => 'Wii U').order('name ASC')
  end

  def xbox
    @title = "Great Xbox Games"
    @games = Game.where(:platform => 'Xbox').order('name ASC')
  end

  def xbox_360
    @title = "Great Xbox 360 Games"
    @games = Game.where(:platform => 'Xbox 360').order('name ASC')
  end

  def xbox_one
    @title = "Great Xbox One Games"
    @games = Game.where(:platform => 'Xbox One').order('name ASC')
  end
end
