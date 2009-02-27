require 'rubygems'
require 'facets'

module Creme  
  def cost
    puts "before_filter"
    super
  end
end

class Coffee
  def cost
    puts "3"
  end
end

Coffee.prepend(Creme)

coffee = Coffee.new
coffee.cost
