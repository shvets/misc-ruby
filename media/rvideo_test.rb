require 'rubygems'
require 'rvideo'


file = RVideo::Inspector.new(:file => "output.wmv")
p file.video_codec  # => mpeg4
p file.audio_codec  # => aac
p file.resolution   # => 320x240

command = "ffmpeg -i $input_file -vcodec xvid -s $resolution$ $output_file$" 
options = {
  :input_file => "output.wmv", 
  :output_file => "processed_file.mp4",
  :resolution => "640x480" 
  }

transcoder = RVideo::Transcoder.new

transcoder.execute(command, options)

transcoder.processed.video_codec # => xvid