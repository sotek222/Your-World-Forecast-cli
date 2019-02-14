def main_menu
    prompt = TTY::Prompt.new
    still_logo
    choice = prompt.select("Hello #{@user.username.light_yellow}, would you like to check the weather?", marker: @sun_marker) do |menu|
      menu.choice 'Look Up New Location'
      menu.choice 'View Saved Locations'
      menu.choice 'Delete Saved Locations'
      menu.choice 'Edit Account'
      menu.choice 'Exit'
    end
  system 'clear'
  case choice
  when 'Look Up New Location'
    still_logo
    puts "Please input your location (City Name, State, and Country): "
    location_response = gets.chomp
    whirly_loader("Accessing Weather Database...")
    location_hash = converter(location_response)
    spacer
    still_logo
    get_weather(location_hash["adminArea5"], location_hash["adminArea1"], location_hash["latLng"])
    spacer
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
