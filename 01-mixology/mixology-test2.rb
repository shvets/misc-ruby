require 'rubygems'
require 'mixology'

module Callback
 def cost
   spoon_required
   super
 end
end

class Coffee
 def spoon_required
   puts "get a spoon to steer sugar || creme"
 end

 def cost
   puts 3
 end
end

coffee = Coffee.new
coffee.mixin Callback

coffee.cost
