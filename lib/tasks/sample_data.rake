namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    create_users
    create_games
    create_wishlists
  end
end

def create_users
  admin = User.create!(email: "hoov1185@gmail.com",
                       password: "foobar1234",
                       password_confirmation: "foobar1234",
                       admin: true)

  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@example.com"
    password  = "password"
    User.create!(email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def create_games
  5.times do |n|
    game = Game.create!(name: "Titanfall",
                        year: "2014",
                        genre: "Sci-Fi",
                        platform: "PC",
                        asin: "B00DTWEOZ8",
                        description: "Crafted by one of the co-creators of Call of Duty and other key developers behind the Call of Duty 
                        franchise, Titanfall, with its advanced combat techniques, gives you the freedom to fight your way as both elite 
                        assault Pilot and fast, heavily armored Titan. The experience combines fast-paced multiplayer action with the 
                        dramatically charged moments of a cinematic universe.")

    game = Game.create!(name: "Watch Dogs",
                        year: "2014",
                        genre: "Modern",
                        platform: "Xbox One",
                        asin: "B00CX8VY4S",
                        description: "In the modern uber-connected world, Chicago has the nation's most advanced and integrated computer 
                        system – one which controls almost every facet of city technology and maintains critical information on all of 
                        the city's residents. You assume the role of Aiden Pearce, a notorious hacker and former thug, whose criminal past 
                        lead to a violent family tragedy. Now on the hunt for those people who have hurt your family, you will be able to 
                        monitor and hack all who surround you while manipulating the city's systems to stop traffic lights, download 
                        personal information, manipulate the electrical grid and more. Use the entire city of Chicago as your personal 
                        weapon and exact your signature brand of revenge.")

  game = Game.create!(name: "Grand Theft Auto V",
                        year: "2013",
                        genre: "Modern",
                        platform: "Xbox 360",
                        asin: "B0050SYILE",
                        description: "Los Santos is a sprawling sun-soaked metropolis full of self-help gurus, starlets and once-important 
                        stars. The city was once the envy of the Western world, but is now struggling to stay relevant in an era of economic 
                        uncertainty and reality TV. Amidst the chaos, three very different criminals chart their own chances of survival and 
                        success: Franklin, a former street gangster, now looking for real opportunities and fat stacks of cash; Michael, a 
                        professional ex-con whose retirement is significantly less rosy than he hoped it would be; and Trevor, a violent maniac 
                        driven by the chance of a cheap high and the next big score. Rapidly running out of options, the crew risks everything 
                        in a series of bolt and dangerous heists that could set them up for the long haul.")

  game = Game.create!(name: "Red Dead Redemption",
                        year: "2010",
                        genre: "Action Adventure",
                        platform: "Playstation 3",
                        asin: "B001SGZL2W",
                        description: "Developed by Rockstar San Diego, as a follow up to the 2004 hit game Red Dead Revolver, Red Dead Redemption 
                        is a Western epic, set at the turn of the 20th century when the lawless and chaotic badlands began to give way to the 
                        expanding reach of government and the spread of the Industrial Age. The story of former outlaw, John Marston, Red Dead 
                        Redemption takes players on a great adventure across the American frontier. Utilizing Rockstar's proprietary Rockstar 
                        Advanced Game Engine (RAGE), Red Dead Redemption features an open-world environment for players to explore, including 
                        frontier towns, rolling prairies teeming with wildlife, and perilous mountain passes - each packed with an endless flow of 
                        varied distractions. Along the way, players experience the heat of gunfights and battles, meet a host of unique characters, 
                        struggle against the harshness of one of the world’s last remaining wildernesses, and ultimately pick their own precarious 
                        path through an epic story about the death of the Wild West and the gunslingers that inhabited it. [Rockstar Games]")

  game = Game.create!(name: "Fez",
                        year: "2014",
                        genre: "2D",
                        platform: "Playstation 4",
                        asin: "Error",
                        description: "In Fez, you play as Gomez, a 2D creature living in what he believes is a 2D world. Until a strange and powerful 
                        artifact reveals to him the existence of a mysterious third dimension!")
  end
end

def create_wishlists
  users  = User.all
  games = Game.all

  games.each do |game|
    users.each do |user|
      user.add_to_wishlist!(game)
      user.add_to_library!(game)
    end
  end
end
