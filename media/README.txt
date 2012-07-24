http://mark.koli.ch/2008/11/howto-convert-videos-to-flash-video-flv-and-play-on-your-site.html
http://www.catswhocode.com/blog/19-ffmpeg-commands-for-all-needs

1. install ffmpeg, mplayer and lame
port install ffmpeg +lame +libogg +vorbis +faac +faad +xvid +x264 +a52 +speex
svn checkout -r 39480 http://svn.macports.org/repository/macports/trunk/dports/audio/lame
cd lame
sudo port install

port install mplayer

2. save mms as wmv
mplayer -dumpstream mms://63.218.83.51/l/3135033-20100311102517-600-9963194.wmv -dumpfile stream.wmv

3.  convert wmv to flv
ffmpeg -sameq -i stream.wmv -vcodec flv -acodec mp3 -ab 64kb stream.flv

or
ffmpeg -i stream.wmv  -ar 22050 -ab 32 -acodec mp3 -s 480x360 -vcodec flv -r 25 -qscale 8 -f flv -y stream.flv

4. produce mp3
ffmpeg -i stream.wmv -vn -ar 44100 -ac 2 -ab 192 -f mp3 sound.mp3
mplayer -dumpaudio mms://63.218.83.51/l/3135033-20100311220852-600-8904387.wmv -dumpfile sound.ac3



mplayer -dumpstream -dumpfile pop_tune.wma mms://gulag.com/pop_tune.wma
mplayer -vo null -vc dummy -ao pcm:file=pop_tune.wav pop_tune.wma
ffmpeg -ab 128 -i pop_tune.wav pop_tune.mp3


mplayer -ao pcm -aofile output.wav mms://38.100.42.165/f/3135033-20100320153300-600-3102508.wmv
$LAME -h $WAV_DIR/`$DATE_FMT`.wav $MP3_DIR/`$DATE_FMT`.mp3 &>

mencoder mms://38.100.42.165/f/3135033-20100320153300-600-3102508.wmv -oac mp3lame -o my_saved_stream.mp3


 ffmpeg -i stream.wmv -target ntsc-dvd -aspect 16:9 -sameq stream.mpg

mplayer mms://63.218.83.51/l/3135033-20100309130005-600-9792906.wmv -ao pcm:file=sound2.wav -vc dummy -aid 1 -vo null
mplayer mms://63.218.83.51/l/3135033-20100309130005-600-9792906.wmv -ao libmp3lame:file=sound2.mp3 -vc dummy -aid 1 -vo null



Profile.create!(:title => "Flash video SD",  :container => "flv", :video_bitrate => 300, :audio_bitrate => 48, :width => 320, :height => 240, :fps => 24, :position => 0, :player => "flash")

Profile.create!(:title => "Flash video HI",  :container => "flv", :video_bitrate => 400, :audio_bitrate => 48, :width => 480, :height => 360, :fps => 24, :position => 1, :player => "flash")

Profile.create!(:title => "Flash h264 SD",   :container => "mp4", :video_bitrate => 300, :audio_codec => "aac", :audio_bitrate => 48, :width => 320, :height => 240, :fps => 24, :position => 2, :player => "flash")

Profile.create!(:title => "Flash h264 HI",   :container => "mp4", :video_bitrate => 400, :audio_bitrate => 48, :audio_codec => "aac", :width => 480, :height => 360, :fps => 24, :position => 3, :player => "flash")

Profile.create!(:title => "Flash h264 480p", :container => "mp4", :video_bitrate => 600, :audio_bitrate => 48, :audio_codec => "aac", :width => 852, :height => 480, :fps => 24, :position => 4, :player => "flash")

- height = '400'
- width = '400'
- url = ''
- screenshot_url = 'stream.flv'

/%embed{:src => "player.swf", :width => width, :height => height, :allowfullscreen => "true", :allowscriptaccess => "always", :flashvars => "&displayheight=#{height}&file=#{url}&image=#{screenshot_url}&width=#{width}&height=#{.height}"}


ffmpeg -i stream.wmv  -ab 128kb -vcodec mpeg4 -b 1200kb -mbd 2 -cmp 2 -subcmp 2 -s 320x180  final_video.mp4








