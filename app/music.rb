require 'thread'

def play_music
  Thread.new do
    loop do
      fork{exec "afplay", "lib/music/01_Where_are_you_now.mp3"}
      sleep 168
      fork{exec "afplay", "lib/music/04_Partly_Cloudy.mp3"}
      sleep 245
      fork{exec "afplay", "lib/music/02_Emerald_Sea_Road.mp3"}
      sleep 190
      fork{exec "afplay", "lib/music/03_Start_Life.mp3"}
      sleep 338
    end
  end
end

def kill_music
  fork{ exec "killall", "afplay"}
end
