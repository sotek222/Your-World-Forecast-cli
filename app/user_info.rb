def user_login
  logo
  puts "Welcome to Your World Forecast, Please enter a Username: ".rjust(70)
  spacer
  user_response = gets.chomp.strip
  @user = User.find_or_create_by(username: user_response)
  system 'clear'
end

def view_account
  still_logo

  puts "Here is your account information:"

  spec_spacer(1)
  table = Terminal::Table.new :title => "Account Info".green do |t|
    t << ['Username'.underline, "#{@user.username}"]
    t.add_separator
    t.add_row ['No. of Locations'.underline, "#{@user.locations.size}"]
    t.add_separator
    t.add_row ['Join Date'.underline, "#{@user.created_at}"]
  end
  table.align_column(1, :center)
  puts table

  spec_spacer(1)
  any_key_prompt = TTY::Prompt.new
  any_key_prompt.keypress("Press any key to return to the main menu".light_yellow.blink)

  system 'clear'

  main_menu
end


def edit_account
  still_logo
  puts "What would you like to do with your account?"
  options = ['Edit Username', 'Delete Account', 'Exit']
  num = 1
  options.each do |opt|
    puts "#{num}. #{opt}"
    num += 1
  end
  puts "Please input a number"
  response = gets.chomp
  case response
  when "1"
    system 'clear'
    update_username
  when "2"
    system 'clear'
    delete_account
  when "3"
    system 'clear'
    main_menu
  else
    puts "Please Enter A Valid Input!".light_yellow
    sleep 1.0
    system 'clear'
    edit_account
  end
end

def update_username
  still_logo
  puts "Please Enter a New Username"
  new_name = gets.chomp.strip
  if User.exists?(username: new_name)
    puts "We're sorry, that username has already been taken.".light_yellow
    puts "Please try again.".light_yellow
    sleep 1.0
    system 'clear'
    update_username
  else
    @user.username = new_name
    puts "New Username: #{@user.username.green.blink}"
    sleep 2.0
    system 'clear'
    main_menu
  end
end

def delete_account
  still_logo
  puts 'Are you sure you want to delete your account? (Y/n)'.light_yellow
  response = gets.chomp.strip.downcase
  if response == "y"
    UserLocation.where(user_id: @user.id).destroy_all
    User.where(id: @user.id).destroy_all
    puts "Sorry to see you go!"
    good_bye
  elsif response == "n"
    main_menu
  else
    puts "Please enter a valid response.".light_yellow
    system 'clear'
    delete_account
  end
end
