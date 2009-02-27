require 'rubygems'
require 'mixology'

module Creme
  def cost
    super + 0.4
  end
end

class Coffee
  def cost
    3
  end
end

coffee = Coffee.new

coffee.mixin Creme
coffee.cost # => 3.4 

puts coffee.cost

# Waitress, please I asked for a black coffee

coffee.unmix Creme
coffee.cost # => 3

puts coffee.cost
