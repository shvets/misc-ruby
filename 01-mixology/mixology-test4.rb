#

require 'rubygems'
require 'mixology'
 
module Callback
  def before_filter filter
    methods = self.class.instance_methods(false)

    methods.delete(filter.to_s)

    methods.each do | filtered_method |
      filter_with filter, filtered_method
    end
  end

  def filter_with filter, filtered_method
    Callback.method_factory(filter, filtered_method)
  end

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
  
  def smell
    puts "good"
  end
  
  def color
    puts "black"
  end
end

coffee = Coffee.new
coffee.mixin Callback
coffee.before_filter :spoon_required

# Every call beneath is prepended by :
#  - "get a spoon to steer sugar || creme" 
coffee.cost
coffee.smell
coffee.color