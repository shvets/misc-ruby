#!/usr/bin/env ruby
require 'rubygems'
require 'spec'
require 'spec/story/runner'
require 'account'

# require all the steps files so that we can link the story to them
Dir[File.join(File.dirname(__FILE__), "steps/*.rb")].each do |file|
  require file
end

# execute the steps in the steps file
with_steps_for :bank do
  run File.expand_path(__FILE__).gsub(".rb","")
end
