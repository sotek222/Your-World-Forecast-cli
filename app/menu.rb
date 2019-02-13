require_relative '../config/environment'
require "pry"
require "colorize"
require "tty-prompt"

def main_menu
    prompt = TTY::Prompt.new

    choice = prompt.select("Hello #{@user.username}, would you like to check the weather?", marker: @sun_marker) do |menu|
      menu.choice 'Look Up New Location'
      menu.choice 'View Saved Locations'
      menu.choice 'Delete Saved Locations'
      menu.choice 'Edit Account'
      menu.choice 'Exit'
    end
  case choice
  when 'Look Up New Location'
    puts "Please input your location (Zipcode or City Name, State): "
    location_response = gets.chomp
    location_hash = converter(location_response)
    spacer
    get_weather(location_hash["adminArea5"], location_hash["latLng"])
    save_location(location_hash)
  when 'View Saved Locations'
    view_saved_locations
  when 'Delete Saved Locations'
    delete_saved_location
  when 'Edit Account'
    edit_account
  else
    puts "Have a Good Day!"
    good_bye
  end
end
