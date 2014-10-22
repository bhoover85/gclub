module MainHelper

  def class_name game
    if game.platform.parameterize == "3ds"
      class_name = "threeds"
    else
      class_name = game.platform.parameterize
    end

    return class_name
  end
end
