ENV['JAVA_HOME'] = "c:/Java/jdk1.5.0"

require 'rubygems'
require 'rjb'

classpath = 'C:/Work/maven-repository/bsh/bsh/2.0b5/bsh-2.0b5.jar'

Rjb::load(classpath, jvmargs=[])

interpreter_class = Rjb::import('bsh.Interpreter')

interpreter_class.main(ARGV)


