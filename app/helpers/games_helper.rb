module GamesHelper

  # Vacuum config for Amazon API
  def self.req_config
    req = Vacuum.new

    req.configure(
      aws_access_key_id:     ENV["AMAZON_ID"],
      aws_secret_access_key: ENV["AMAZON_KEY"],
      associate_tag:         ENV["AMAZON_TAG"]
    )
  end

  def req_config
    GamesHelper.req_config
  end

  # Get item's asin from Amazon
  def self.get_asin(name, platform)
    req = req_config()

    params = {
      'SearchIndex' => 'VideoGames',
      'Keywords'    => "#{name} #{platform}"
    }

    res = req.item_search(query: params).to_h

    if res['ItemSearchResponse']['Items']['Request'].include?('Errors')
      asin = "Error"
    else
      asin = res['ItemSearchResponse']['Items']['Item'].first['ASIN']
    end

    return asin
  end

  def get_asin(name, platform)
    GamesHelper.get_asin(name, platform)
  end

  # Get item information from Amazon
  def self.amazon_info(asin, response)
    req = req_config()

    params = {
      'ItemId'        => asin,
      'Condition'     => 'All',
      'ResponseGroup' => response
    }

    sleep 1
    res = req.item_lookup(query: params).to_h
    res = res['ItemLookupResponse']['Items']['Item']

    item_attributes  = res['ItemAttributes']
    offer_summary    = res['OfferSummary']
    item_link        = res['ItemLinks']['ItemLink']
    similar          = res['SimilarProducts']['SimilarProduct']

    # Get similar product titles and links
    similar_products = Hash.new
    similar.each do |product|
      similar_products[product['Title']] = similar_products_url(product['ASIN'])
    end

    amazon = []

    game = OpenStruct.new
    game.list_price       = item_attributes['ListPrice']['FormattedPrice'] if item_attributes['ListPrice']
    game.lowest_price     = offer_summary['LowestNewPrice']['FormattedPrice'] if offer_summary['LowestNewPrice']
    game.savings          = "$0.00"
    game.page_url         = res['DetailPageURL']
    game.wishlist_url     = get_wishlist_url(item_link)
    game.similar_products = similar_products

    amazon << game

    return amazon
  end

  def amazon_info(asin, response)
    GamesHelper.amazon_info(asin, response)
  end

  def calc_savings(list_price, lowest_price)
    return number_to_currency(list_price.gsub(/[^\d\.]/, '').to_f - lowest_price.gsub(/[^\d\.]/, '').to_f)
  end

  def self.get_wishlist_url(item_link)
    item_link.each do |item|
      if item['Description'] == "Add To Wishlist"
        @add_to_wishlist = item['URL']
      end
    end

    return @add_to_wishlist
  end

  def get_wishlist_url(item_link)
    GamesHelper.get_wishlist_url(item_link)
  end

  # Return similar product URLs of current game
  def self.similar_products_url(asin)
    req = req_config()

    params = {
      'ItemId'        => asin,
      'Condition'     => 'All'
    }

    sleep 1
    res = req.item_lookup(query: params).to_h

    return res['ItemLookupResponse']['Items']['Item']['DetailPageURL']
  end

  def similar_products_url(asin)
    GamesHelper.similar_products_url(asin)
  end

  # Returns metacritic information on a game.
  # 1 = PS3, 2 = Xbox360, 3 = PC, 72496 = PS4, 80000 = Xbox One
  def self.metacritic_info(name, platform)
    case platform.downcase
    when "playstation 3"
      platform = 1
    when "xbox 360"
      platform = 2
    when "pc"
      platform = 3
    when "ds"
      platform = 4
    when "playstation 2"
      platform = 6
    when "psp"
      platform = 7
    when "wii"
      platform = 8
    when "playstation"
      platform = 10
    when "game boy advance"
      platform = 11
    when "xbox"
      platform = 12
    when "gamecube"
      platform = 13
    when "nintendo 64"
      platform = 14
    when "dreamcast"
      platform = 15
    when "3ds"
      platform = 16
    when "playstation vita"
      platform = 67365
    when "wii u"
      platform = 68410
    when "playstation 4"
      platform = 72496
    when "xbox one"
      platform = 80000
    end
    
    sleep 1
    response = Unirest::post "https://byroredux-metacritic.p.mashape.com/find/game", 
      headers: { 
        "X-Mashape-Authorization" => ENV["MASHAPE_KEY"]
      },
      parameters: { 
        "title"    => name,
        "platform" => platform,
        "retry"    => 4
      }

    metacritic = []

    req = OpenStruct.new
    req.score     = response.body['result']['score']
    req.rlsdate   = response.body['result']['rlsdate']
    req.publisher = response.body['result']['publisher']
    req.developer = response.body['result']['developer']
    req.genre     = response.body['result']['genre']
    req.url       = response.body['result']['url']

    sleep 1
    response = Unirest.get "https://byroredux-metacritic.p.mashape.com/reviews?sort=most-active&url=" + req.url,
      headers: {
        "X-Mashape-Key" => ENV["MASHAPE_KEY"]
      }

    req.critic_reviews = response.body['result']


    metacritic << req

    return metacritic
  end

  def metacritic_info(name, platform)
    GamesHelper.metacritic_info(name, platform)
  end

  def game_table_column(action)
    case action
    when "owned", "index"
      column = "score"
    when "wanted"
      column = "lowest_price"
    end

    return column
  end

  def game_table_data(game, action)
    case action
    when "owned", "index"
      data = game.score
    when "wanted"
      data = game.lowest_price ? game.lowest_price : "N/A"
    end

    return data
  end
end
