module GamesHelper

  # Vacuum config for Amazon API
  def req_config
    req = Vacuum.new

    req.configure(
      aws_access_key_id:     ENV["AMAZON_ID"],
      aws_secret_access_key: ENV["AMAZON_KEY"],
      associate_tag:         ENV["AMAZON_TAG"]
    )
  end

  # Amazon item search
  def item_search(name, platform)
    req = req_config()

    params = {
      'SearchIndex' => 'VideoGames',
      'Keywords'    => "#{name} #{platform}"
    }

    res = req.item_search(query: params).to_h

    if res['ItemSearchResponse']['Items']['Request'].include?('Errors')
      @asin = "Error"
    else
      @asin = res['ItemSearchResponse']['Items']['Item'].first['ASIN']
    end
  end

  # Amazon item lookup
  def item_lookup(asin, response)
    req = req_config()

    params = {
      'ItemId'        => asin,
      'Condition'     => 'All',
      'ResponseGroup' => response
    }

    @res = req.item_lookup(query: params).to_h
    @res = @res['ItemLookupResponse']['Items']['Item']

    editorial_review = @res['EditorialReviews']['EditorialReview']
    item_attributes  = @res['ItemAttributes']
    offer_summary    = @res['OfferSummary']
    item_link        = @res['ItemLinks']['ItemLink']
    similar_products = @res['SimilarProducts']['SimilarProduct']

    # Session variables for view
    # @release_date     = item_attributes['ReleaseDate']
    # @publisher        = item_attributes['Publisher']
    @list_price       = item_attributes['ListPrice']['FormattedPrice']
    @lowest_price     = offer_summary['LowestNewPrice']['FormattedPrice']
    @savings          = number_to_currency(@list_price.gsub(/[^\d\.]/, '').to_f - @lowest_price.gsub(/[^\d\.]/, '').to_f)
    @similar_products = similar_products

    @review = (editorial_review.is_a? Array) ? editorial_review.first['Content'] : editorial_review['Content']

    x=0
    item_link.each do |item|
      if item_link[x]['Description'] == "Add To Wishlist"
        @add_to_wishlist = item_link[x]['URL']
      end
      x+=1
    end
  end

  # Return similar product URLs of current game
  def similar_products_url(asin)
    req = req_config()

    params = {
      'ItemId'        => asin,
      'Condition'     => 'All'
    }

    res = req.item_lookup(query: params).to_h

    return res['ItemLookupResponse']['Items']['Item']['DetailPageURL']
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
    @rlsdate   = response.body['result']['rlsdate']
    @platform  = response.body['result']['platform']
    @publisher = response.body['result']['publisher']
    @developer = response.body['result']['developer']
    @genre     = response.body['result']['genre']
  end
end
