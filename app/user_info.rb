def user_login
  logo
  puts "Welcome to Your World Forecast, Please enter a Username: ".rjust(70)
  spacer
  user_response = gets.chomp.strip
  @user = User.find_or_create_by(username: user_response)
  system 'clear'
end

def edit_account
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
    puts "Please Enter A Valid Input!".yellow
    sleep 1.0
    system 'clear'
    edit_account
  end
end

def update_username
  puts "Please Enter a New Username"
  new_name = gets.chomp.strip
  if User.exists?(username: new_name)
    puts "We're sorry, that username has already been taken."
    puts "Please try again."
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
  puts 'Are you sure you want to delete your account? (Y/n)'.yellow
  response = gets.chomp.strip.downcase
  if response == "y"
    UserLocation.where(user_id: @user.id).destroy_all
    User.where(id: @user.id).destroy_all
    puts "Sorry to see you go!"
    good_bye
  elsif response == "n"
    main_menu
  else
    puts "Please enter a valid response.".yellow
    delete_account
  end
end
