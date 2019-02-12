puts "Please input your location in the following format (Town or City, State): "
location_response = gets.chomp
location = LocationConversion.new(location_response)
coordinates = location.converter
