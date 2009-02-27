ENV['JAVA_HOME'] = "c:/Java/jdk1.5.0"

require 'rubygems'
require 'rjb'

Rjb::load(classpath = '.', jvmargs=[])

str_class = Rjb::import('java.lang.String')  # import String class into the varibale 'str'

str = str_class.new("test")

str.to_s do
  toString()
end

puts str.toString

