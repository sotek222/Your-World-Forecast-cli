require_relative '../config/environment'
require_all 'app'
require "pry"
require "colorize"
require "tty-prompt"
require 'whirly'
require 'paint'



system 'clear'
time_symbol
play_music
sleep 1.0
spacer
user_login
whirly_loader("Loading Your Account...")
main_menu
