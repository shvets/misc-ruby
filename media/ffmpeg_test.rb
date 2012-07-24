require 'rubygems'
require 'ffmpeg-ruby'
require 'open-uri'

p "Get a list of the audio codecs supported:"
p FFMpeg::AVCodec.supported_audio_codecs
#p FFMpeg::AVCodec.supported_audio_codecs[0].class
p "Get a list of the audio codecs supported:"
p FFMpeg::AVCodec.supported_video_codecs

# Create new AVFormatContext

f = FFMpeg::AVFormatContext.new("output.wmv")
 
f.codec_contexts.each{ |ctx|
  puts ctx.name # The name of the codec this file uses.
}