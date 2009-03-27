require 'ftools'

txt = IO.read("data.xml")
data = txt.scan(/<data>(.*?)<\/data>/im).flatten[0]
hash = {}
data.scan(/<([^>]*?)>(.*?)<\/[^>]*?>/im){|i| hash[i[0]] = i[1].strip}

hash.each do |k, v|
  puts "#{k}: #{v}"
end