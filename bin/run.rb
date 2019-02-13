require_relative '../config/environment'
require_all 'app'
require "pry"
require "colorize"
require "tty-prompt"

system 'clear'
play_music
sleep 1.0
logo
spacer
user_login
system 'clear'
main_menu
