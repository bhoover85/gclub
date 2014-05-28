namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    create_users
    create_games
  end
end

def create_users
  admin = User.create!(email: "hoov1185@gmail.com",
                       password: "foobar1234",
                       password_confirmation: "foobar1234",
                       admin: true)

  9.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@example.com"
    password  = "password"
    User.create!(email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def create_games
  game = Game.create!(name: "Titanfall",
                      year: "2014",
                      genre: "Sci-Fi",
                      platform: "PC",
                      description: "Crafted by one of the co-creators of Call of Duty and other key developers behind the Call of Duty 
                      franchise, Titanfall, with its advanced combat techniques, gives you the freedom to fight your way as both elite 
                      assault Pilot and fast, heavily armored Titan. The experience combines fast-paced multiplayer action with the 
                      dramatically charged moments of a cinematic universe.")

  game = Game.create!(name: "Watch Dogs",
                      year: "2014",
                      genre: "Modern",
                      platform: "Xbox One",
                      description: "In the modern uber-connected world, Chicago has the nation's most advanced and integrated computer 
                      system – one which controls almost every facet of city technology and maintains critical information on all of 
                      the city's residents. You assume the role of Aiden Pearce, a notorious hacker and former thug, whose criminal past 
                      lead to a violent family tragedy. Now on the hunt for those people who have hurt your family, you will be able to 
                      monitor and hack all who surround you while manipulating the city's systems to stop traffic lights, download 
                      personal information, manipulate the electrical grid and more. Use the entire city of Chicago as your personal 
                      weapon and exact your signature brand of revenge.")
end