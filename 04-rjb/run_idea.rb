ENV['JAVA_HOME'] = "c:/Java/jdk1.6.0"

require 'rubygems'
require 'rjb'

java_home = ENV['JAVA_HOME']
idea_home = 'C:/Work/Editors/IntelliJ IDEA 9742'

classpath = java_home + '/../lib/tools.jar'
classpath = classpath + ";" + idea_home + '/lib/bootstrap.jar'
classpath = classpath + ";" + idea_home + '/lib/boot.jar'
classpath = classpath + ";" + idea_home + '/bin'
classpath = classpath + ";" + idea_home + '/lib/idea.jar'
classpath = classpath + ";" + idea_home + '/lib/openapi.jar'
classpath = classpath + ";" + idea_home + '/lib/jdom.jar'
classpath = classpath + ";" + idea_home + '/lib/log4j.jar'
classpath = classpath + ";" + idea_home + '/lib/extensions.jar'
classpath = classpath + ";" + idea_home + '/lib/util.jar'

puts classpath

Rjb::load(classpath, jvmargs=[])

interpreter_class = Rjb::import('com.intellij.idea.Main')

interpreter_class.main(ARGV)


