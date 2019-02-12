class LocationConversion

  @@all = []

  def initialize(location)
    @location = location
    @@all << self
  end

  def converter
    map_string = RestClient.get("http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_QUEST_API_KEY']}&location=#{@location}")
    map_hash = JSON.parse(map_string)
    lat_lng_hash = map_hash["results"][0]["locations"][0]["latLng"]
  end

end
