require_relative '../config/environment'
require_all 'app'
require "pry"
require "colorize"
require "tty-prompt"

play_music
sleep 1.0
logo
user_login
main_menu
