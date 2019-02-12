require_relative '../config/environment'
require_relative '../app/intro'
require_relative '../app/models/user'
require_relative '../app/models/location'
require_relative '../app/models/user_location'
require_relative '../app/location_conversion'

require "pry"
require "colorize"
require "tty-prompt"

# fork{ exec "clear"}

puts "Please input your location in the following format (Town or City, State): "
location_response = gets.chomp
location = LocationConversion.new(location_response)
coordinates = location.converter
################# Using the MapQuest API gets the longitude and latitude of any town/state given ##################################
# map_string = RestClient.get("http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_QUEST_API_KEY']}&location=#{location}")
# map_hash = JSON.parse(map_string)


####################### Using Dark Star API we need to take the long, and lat from the above api and use it #####################
response_string = RestClient.get("https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/#{coordinates["lat"]},#{coordinates["lng"]}")
response_hash = JSON.parse(response_string)

puts "#{response_hash["currently"]["temperature"]} degrees"


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
