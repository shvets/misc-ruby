# http://kpumuk.info/ruby-on-rails/encoding-media-files-in-ruby-using-ffmpeg-mencoder-with-progress-tracking/

$:.unshift(File::join(File::dirname(File::dirname(__FILE__)), "lib"))

require 'executor'

#command_mencoder = "mencoder stream.wmv -o output.avi -oac lavc -ovc lavc -lavcopts vcodec=xvid:acodec=mp3"

command_mencoder = "mencoder --progress stream.wmv -ovc lavc -oac mp3lame -o output.avi"

command_ffmpeg = "ffmpeg -y -i stream.wmv output.avi 2>&1"

executor = Executor.new

begin
  executor.execute_mencoder(command_mencoder)
  #executor.execute_ffmpeg(command_ffmpeg)
  #executor.execute_ffmpeg2(command_ffmpeg)
rescue Exception => e
  p e
  print "ERROR\n"
  exit 1
end