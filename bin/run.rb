require_relative '../config/environment'
require "pry"
require "colorize"
require_relative '../lib/intro'

response_string = RestClient.get("https://api.darksky.net/forecast/#{ENV['API_KEY']}/42.3601,-71.0589")
response_hash = JSON.parse(response_string)
