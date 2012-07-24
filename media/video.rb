require 'rubygems'
require 'sinatra'
require 'haml'


get '/' do
  haml :index
end

post '/' do
  convert_video
  
  haml :play_video  
end

get '/play_video' do
  haml :play_video  
end

def convert_video
  # input_file_name = File.expand_path(File.dirname(__FILE__) + "/#{params[:input_name]}")
  # File.open(input_file_name, 'w')
  # 
  # command = <<-text
  #   ffmpeg -i #{ input_file_name }  -ar 22050 -ab 32 -acodec mp3
  #   -s 480x360 -vcodec flv -r 25 -qscale 8 -f flv -y #{ flv }
  # text
  # command.gsub!(/\s+/, " ")
end

# ffmpeg -i output.wmv output2.wmv
# ffmpeg -i output.wmv -acodec mp3 -y output2.wmv
# ffmpeg -f oss -i /dev/dsp -f video4linux2 -i /dev/video0 /tmp/out.mpg

