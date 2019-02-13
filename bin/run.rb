require_relative '../config/environment'
require_relative '../app/models/user'
require_relative '../app/models/location'
require_relative '../app/models/user_location'
require_relative '../app/formatter'
require_relative '../app/intro'
require_relative '../app/menu'
require_relative '../app/user_location_info'
require_relative '../app/get_weather'
require_relative '../app/user_info'
require "pry"
require "colorize"
require "tty-prompt"


# logo
user_login
main_menu
