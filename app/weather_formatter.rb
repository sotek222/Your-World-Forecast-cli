def weather_by_position(response_hash, range, num)
  response_hash["daily"]["data"][num]["temperature#{range}"]
end

def date_by_position(response_hash, num)
  DateTime.strptime(response_hash["daily"]["data"][num]["time"].to_s,'%s').asctime
end

def weather_row(response_hash, num, table_builder)
  table_builder.add_separator
  table_builder.add_row [date_by_position(response_hash, num), ""]
  table_builder.add_separator
  table_builder.add_row ["#{'High:'.green.underline} #{weather_by_position(response_hash, "High", num)} degrees", "#{'Low:'.green.underline} #{weather_by_position(response_hash, "Low", num)} degrees"]
end

def current_weather(response_hash, table_builder)
  table_builder.add_separator
  table_builder.add_row ['Current Temperature'.green.underline, "#{response_hash["currently"]["temperature"]} degrees"]
  table_builder.add_separator
  table_builder.add_row ['Summary'.green.underline, "#{response_hash["currently"]["summary"]}"]
end
