def save_location(location_hash)
  save_prompt = TTY::Prompt.new

  confirmation = save_prompt.yes?('Would you like to save this location?')
  if confirmation
    location = Location.find_or_create_by(city: location_hash["adminArea5"], country: location_hash["adminArea1"], latitude: location_hash["latLng"]["lat"], longitude: location_hash["latLng"]["lng"])
    UserLocation.find_or_create_by(user_id: @user.id, location_id: location.id)
    @user.locations.reload
    puts 'Saved Successfully'
    spacer
    main_menu
  else
    main_menu
  end
end

def view_saved_locations
  select_prompt = TTY::Prompt.new

  menu_choice = select_prompt.select("Here are your saved locations:", marker: @sun_marker) do |menu|
    menu.choice "Exit"
    @user.locations.each do |location|
      menu.choice "#{location.city}, #{location.country}"
    end
  end
  if menu_choice == "Exit"
    main_menu
  else
    any_key_prompt = TTY::Prompt.new
    selected_local = converter(menu_choice)
    get_weather(selected_local["adminArea5"], selected_local["adminArea1"], selected_local["latLng"])
    any_key_prompt.keypress("Press any key to return to the main menu".blink)
    system 'clear'
    main_menu
  end
end

def delete_saved_location
  delete_prompt = TTY::Prompt.new
  delete_response = delete_prompt.select("Here are your saved locations please select a location to delete:", marker: @sun_marker) do |menu|
    menu.choice "Exit"
    @user.locations.each do |location|
      menu.choice "#{location.city}, #{location.country}"
    end
  end
  if delete_response == "Exit"
    main_menu
  else
    location = Location.find_by(city: delete_response.split(", ").first)
    UserLocation.where(location_id: location.id, user_id: @user.id).destroy_all
    @user.locations.reload
    puts "Location successfully deleted!"
    sleep 1.0
    main_menu
  end
end
