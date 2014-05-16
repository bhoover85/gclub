module GamesHelper

  # Get product information from Amazon.
  def amazon_info(name, platform, response)
    req = Vacuum.new

    req.configure(
      aws_access_key_id:     ENV["AMAZON_ID"],
      aws_secret_access_key: ENV["AMAZON_KEY"],
      associate_tag:         ENV["AMAZON_TAG"]
    )

    params = {
      'SearchIndex' => 'VideoGames',
      'Keywords'    => "#{name} #{platform}"
    }

    res = req.item_search(query: params).to_h
    res = res['ItemSearchResponse']['Items']['Item'].first['ASIN']

    params = {
      'ItemId' => res,
      'ResponseGroup' => response,
      'MerchantId' => 'Amazon'
    }

    @res = req.item_lookup(query: params).to_h

    item_attributes = @res['ItemLookupResponse']['Items']['Item']['ItemAttributes']
    editorial_review = @res['ItemLookupResponse']['Items']['Item']['EditorialReviews']['EditorialReview']
    
    @rlsdate = item_attributes['ReleaseDate']
    @review = editorial_review['Content']
  end


  # Returns metacritic information on a game.
  # 1 = PS3, 2 = Xbox360, 3 = PC, 72496 = PS4, 80000 = Xbone
  def metacritic_info(name, platform)
    case platform.downcase!
    when "playstation 3"
      platform = 1
    when "xbox 360"
      platform = 2
    when "pc"
      platform = 3
    when "wii"
      platform = 8
    when "wii u"
      platform = 68410
    when "playstation 4"
      platform = 72496
    when "xbox one"
      platform = 80000
    end
    
    response = Unirest::post "https://byroredux-metacritic.p.mashape.com/find/game", 
      headers: { 
        "X-Mashape-Authorization" => "ElTFsB39JKhu7EpQxrqksMhe9xhrzioJ"
      },
      parameters: { 
        "title" => name,
        "platform" => platform
      }

    @name      = response.body['result']['name']
    @thumbnail = response.body['result']['thumbnail']
    @score     = response.body['result']['score']
    # @rlsdate   = response.body['result']['rlsdate']
    @platform  = response.body['result']['platform']
    @publisher = response.body['result']['publisher']
    @developer = response.body['result']['developer']
    @genre     = response.body['result']['genre']
  end
end
