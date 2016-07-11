require './config/environment.rb'

Track.connection

Track.all.each do |track|
  track.touch
  track.save
end
