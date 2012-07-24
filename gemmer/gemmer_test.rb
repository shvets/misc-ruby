require 'rubygems'

$:.unshift(File::join(File::dirname(__FILE__), "lib"))

require 'gemmer'

include Gemmer

require 'google_translate'

translator = Google::Translator.new

puts translator.translate(:en, :ru, "hello world")

__END__

gem "google-translate", "0.7.2"
