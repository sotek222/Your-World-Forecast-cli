@sun_marker = "☼"

def spacer
  puts "\n\n"
end

def clear
  fork {exec "clear"}
end

def good_bye
  sleep 1.0
  clear
  exit
end
