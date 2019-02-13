require_relative '../config/environment'
require_relative '../app/intro'
require_relative '../app/get_weather'
require_relative '../app/models/user'
require_relative '../app/models/location'
require_relative '../app/models/user_location'

require "pry"
require "colorize"
require "tty-prompt"

@sun_marker = "☼"

def spacer
  puts "\n\n"
end

def converter(location)
  map_string = RestClient.get("http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_QUEST_API_KEY']}&location=#{location}")
  map_hash = JSON.parse(map_string)
  map_hash["results"][0]["locations"][0]
end


def user_login
  puts "Welcome to My World Forecast, Please enter a Username: "
  user_response = gets.chomp
  @user = User.find_or_create_by(username: user_response)
end



def main_menu
  prompt = TTY::Prompt.new

  choice = prompt.select("Hello #{@user.username}, would you like to check the weather?", marker: @sun_marker) do |menu|
    menu.choice 'Look Up New Location'
    menu.choice 'View Saved Locations'
    menu.choice 'Delete Saved Locations'
    menu.choice 'Delete Account'
    menu.choice 'Exit'
  end

  if choice == 'Look Up New Location'
    puts "Please input your location: "
    location_response = gets.chomp
    location_hash = converter(location_response)

    spacer
    get_weather(location_hash["adminArea5"], location_hash["latLng"])

    save_prompt = TTY::Prompt.new

    confirmation = save_prompt.yes?('Would you like to save this location?')
    if confirmation
      location = Location.find_or_create_by(city: location_hash["adminArea5"], country: location_hash["adminArea1"], latitude: location_hash["latLng"]["lat"], longitude: location_hash["latLng"]["lng"])
      UserLocation.find_or_create_by(user_id: @user.id, location_id: location.id)
      scroll_text('Saved Successfully')
      puts "\n"
      main_menu
    else
      main_menu
    end
  elsif choice == 'View Saved Locations'
    select_prompt = TTY::Prompt.new

    select_prompt.select("Here are your saved locations:", marker: @sun_marker) do |menu|
      menu.choice "Exit"
      @user.locations.each do |location|
        menu.choice "#{location.city}"
      end
    end
  elsif choice == 'Delete Saved Locations'
    delete_prompt = TTY::Prompt.new
    delete_response = delete_prompt.select("Here are your saved locations please select a location to delete:", marker: @sun_marker) do |menu|
      menu.choice "Exit"
      @user.locations.each do |location|
        menu.choice "#{location.city}"
      end
    end
    if delete_response == "Exit"
      main_menu
    else
      location = Location.find_by(city: delete_response)
      UserLocation.where(location_id: location.id, user_id: @user.id).destroy_all
      @user.locations.reload
      main_menu
    end
  elsif choice == 'Delete Account'
    delete_prompt = TTY::Prompt.new
    response = delete_prompt.yes?('Are you sure you want to delete your account?')
    if response == true
      UserLocation.where(user_id: @user.id).destroy_all
      User.where(id: @user.id).destroy_all
      user_login
    else
      main_menu
    end
  else
    puts "Have a Good Day!"
    sleep 1.0
    fork {exec "clear"}
    exit
  end
end


user_login
main_menu
