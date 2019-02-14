@sun_marker = "🌤"

def time_symbol
  if Time.now.hour >= 5 && Time.now.hour < 18
    @sun_marker = "🌤"
  else
    @sun_marker = "🌙"
  end
end

def scroll_text(text)
  text.each_char do |c|
    print c
    sleep (0.002)
  end
end

def spacer
  puts "\n\n"
end

# def spacer(number)
#   number.times do
#     puts "\n"
#   end
# end

def good_bye
  sleep 1.0
  system 'clear'
  kill_music
  exit
end

def current_time
  puts "The current local time is: #{Time.now.asctime}"
end

def whirly_loader(message)
  Whirly.start(spinner: "cloud")
  Whirly.status = message
  sleep 2.5
  Whirly.stop
  system 'clear'
end
