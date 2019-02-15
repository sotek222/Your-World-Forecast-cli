
def converter(location)
  map_string = RestClient.get("http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_QUEST_API_KEY']}&location=#{location}&maxResults=1")
  map_hash = JSON.parse(map_string)
  map_hash["results"][0]["locations"][0]
end

def get_weather(city_name, country_name, coordinates)
  response_string = RestClient.get("https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/#{coordinates["lat"]},#{coordinates["lng"]}")
  response_hash = JSON.parse(response_string)

  spec_spacer(1)
  
  table = Terminal::Table.new :title => "Current Local Forecast".light_yellow do |t|
  t << ['Location'.green.underline, "#{city_name}, #{country_name}"]
  t.add_separator
  t.add_row ['Temperature'.green.underline, "#{response_hash["currently"]["temperature"]} degrees"]
  t.add_separator
  t.add_row ['Summary'.green.underline, "#{response_hash["currently"]["summary"]}"]
  end
  puts table
  spec_spacer(1)
  current_time
  spec_spacer(1)
end
