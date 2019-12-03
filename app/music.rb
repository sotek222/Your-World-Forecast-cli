require 'mp3info'

def play_music

  songs = [
  'lib/music/05_Where_are_you_now.mp3',
  'lib/music/04_Partly_Cloudy.mp3',
  'lib/music/02_Emerald_Sea_Road.mp3',
  'lib/music/03_Start_Life.mp3',
  'lib/music/01_Current_Local_Conditions.mp3'
  ]

  played_songs = []

  Thread.new do
    loop do
      if songs.empty?
        songs = played_songs
        played_songs.clear
      else
        song = songs[rand(songs.count)]
        played_songs << song
        songs.reject! {|s| s == song}
        fork{exec "afplay", song}
        sleep Mp3Info.open(song).length.round
      end
    end
  end
end

def kill_music
  fork { exec 'killall', 'afplay' }
end
