@sun_marker = "☼"

def scroll_text(text)
  text.each_char do |c|
    print c
    sleep (0.002)
  end
end

def spacer
  puts "\n\n"
end

def good_bye
  sleep 1.0
  system 'clear'
  kill_music
  exit
end
