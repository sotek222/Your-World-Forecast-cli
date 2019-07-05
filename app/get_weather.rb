require "date"
def converter(location)
  map_string = RestClient.get("http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_QUEST_API_KEY']}&location=#{location}&maxResults=1")
  map_hash = JSON.parse(map_string)
  map_hash["results"][0]["locations"][0]
end

def get_weather(city_name, country_name, coordinates)
  response_string = RestClient.get("https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/#{coordinates["lat"]},#{coordinates["lng"]}")
  response_hash = JSON.parse(response_string)
  spec_spacer(1)
  build_table(city_name, country_name, response_hash)
  spec_spacer(1)
  current_time
  spec_spacer(1)
end

def build_table(city_name, country_name, response_hash)
  table = Terminal::Table.new :title => "Your World Forecast".light_yellow do |t|
    t << ['Location'.green.underline, "#{city_name}, #{country_name}"]
    weather_row(response_hash, 0, t)
    weather_row(response_hash, 1, t)
    weather_row(response_hash, 2, t)
    weather_row(response_hash, 3, t)
    weather_row(response_hash, 4, t)
    weather_row(response_hash, 5, t)
    weather_row(response_hash, 6, t)
    weather_row(response_hash, 7, t)
    current_weather(response_hash, t)
  end
  puts table
end
