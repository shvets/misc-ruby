#

require 'rubygems'
require 'mixology'
 
module Callback
  def before_filter filter, filtered_method
    Callback.method_factory(filter, filtered_method)
  end
  
  # Needed define_method here so it's called in module's context
  def self.method_factory(filter, filtered_method)
    define_method(filtered_method) do
      send filter
      super
    end
  end
end

class Coffee
  def spoon_required
    puts "get a spoon to steer sugar || creme"
  end
  
  def cost
    puts "3"
  end
end

coffee = Coffee.new
coffee.mixin Callback
coffee.before_filter :spoon_required, :cost
coffee.cost
