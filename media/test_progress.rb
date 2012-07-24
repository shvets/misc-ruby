# http://kpumuk.info/ruby-on-rails/encoding-media-files-in-ruby-using-ffmpeg-mencoder-with-progress-tracking/

require 'progressbar'

class MediaFormatException <  StandardError
end


def execute_mencoder(command)
  progress = nil
  IO.popen(command) do |pipe|
    pipe.each("\r") do |line|
      if line =~ /Pos:[^(]*(\s*(\d+)%)/
        p = $1.to_i
        p = 100 if p > 100
        if progress != p
          progress = p
          print "PROGRESS: #{progress}\n"
          $defout.flush
        end
      end
    end
  end
  raise MediaFormatException if $?.exitstatus != 0
end

def execute_ffmpeg(command)
  progress = nil
  duration = 0
  IO.popen(command) do |pipe|
    pipe.each("\r") do |line|
      if line =~ /Duration: (\d{2}):(\d{2}):(\d{2}).(\d{1})/
        duration = (($1.to_i * 60 + $2.to_i) * 60 + $3.to_i) * 10 + $4.to_i
      end

      if line =~ /time=(\d+).(\d+)/
        if not duration.nil? and duration != 0
          p = ($1.to_i * 10 + $2.to_i) * 100 / duration
        else
          p = 0
        end
        p = 100 if p > 100
        if progress != p
          progress = p
          print "PROGRESS: #{progress}\n"
          $defout.flush
        end
      end
    end
  end
  raise MediaFormatException if $?.exitstatus != 0
end

def execute_ffmpeg2(command)
  pbar = ProgressBar.new("test", 100)

  duration = 0
  
  IO.popen(command) do |pipe|
    pipe.each("\r") do |line|
      if line =~ /Duration: (\d{2}):(\d{2}):(\d{2}).(\d{1})/
        duration = (($1.to_i * 60 + $2.to_i) * 60 + $3.to_i) * 10 + $4.to_i
      end

      if line =~ /time=(\d+).(\d+)/
        if not duration.nil? and duration != 0
          pos = ($1.to_i * 10 + $2.to_i) * 100 / duration
        else
          pos = 0
        end

        pos = 100 if pos > 100

        pbar.set(pos) if pbar.current != pos
      end
    end
  end

  pbar.finish
end


def get_video_file_duration(inputFilename)
            command = "ffmpeg -i "
                             + inputFilename.to_s + "
                             2>&amp;1 | grep 'Duration'
                             | cut -d ' ' -f 4 | sed s/,//"
                             output = `#{command}`

          if output =~ /([\d][\d]):([\d][\d]):([\d][\d]).([\d]+)/
               duration = (($1.to_i * 60 + $2.to_i) * 60 + $3.to_i) * 10 + $4.to_i
          end

          #return duration.to_s
          return "#{$2}:#{$3}"
end

command_mencoder = "mencoder stream.wmv -o output.avi -oac lavc -ovc lavc -lavcopts vcodec=xvid:acodec=mp3"
command_ffmpeg = "ffmpeg -y -i stream.wmv output.avi 2>&1"

begin
  #execute_mencoder(command_mencoder)
  #execute_ffmpeg(command_ffmpeg)
  execute_ffmpeg2(command_ffmpeg)
rescue Exception => e
  p e
  print "ERROR\n"
  exit 1
end