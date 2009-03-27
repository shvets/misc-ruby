require 'open-uri'

url = "http://mlmusic.38th.ru"

open(url) do |stream|
  while (line = stream.gets)
    puts line
  end
end

