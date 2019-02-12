require_relative '../config/environment'
require_relative '../app/intro'
require_relative '../app/get_weather'
require_relative '../app/models/user'
require_relative '../app/models/location'
require_relative '../app/models/user_location'

require "pry"
require "colorize"
require "tty-prompt"

def converter(location)
  map_string = RestClient.get("http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_QUEST_API_KEY']}&location=#{location}")
  map_hash = JSON.parse(map_string)
  map_hash["results"][0]["locations"][0]
end



puts "Welcome to My World Forecast, Please enter a Username: "
user_response = gets.chomp
user = User.find_or_create_by(username: user_response)

prompt = TTY::Prompt.new

choice = prompt.select("Welcome #{user.username}, where would you like to check the weather? ") do |menu|
  menu.choice 'Look Up New Location'
  menu.choice 'View Saved Locations'
  menu.choice 'Exit'
end

if choice == 'Look Up New Location'
  puts "Please input your location in the following format (Town or City, State): "
  location_response = gets.chomp
  location_hash = converter(location_response)


  get_weather(location_hash["latLng"])

  save_prompt = TTY::Prompt.new

  confirmation = save_prompt.yes?('Would you like to save this location?')
  if confirmation
    Location.find_or_create_by(city: location_hash["adminArea5"], country: location_hash["adminArea1"], latitude: location_hash["latLng"]["lat"], longitude: location_hash["latLng"]["lng"])
    User_location.create(user.id, location.id)
  else
    puts "WIP"
  end
elsif choice == 'View Saved Locations'
  puts ":)"
else
  puts "Have a Good Day!"
  exit
end



################Example of using tty-prompt########################
# prompt = TTY::Prompt.new
#
# prompt.select("Welcome User, please select an option") do |menu|
#   menu.choice 'New York'
#   menu.choice 'Boston'
#   menu.choice 'Long Beach'
#   menu.choice 'Detroit'
#   menu.choice 'San Fransico'
#   menu.choice 'Check New Location'
# end
###################################################################
