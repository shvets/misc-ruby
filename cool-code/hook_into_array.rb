module TheModule
  attr_reader :items
  def initialize(*args)
    @items = []
 
    def @items.<<(item)
      super
      "You added the item #{item} with <<!"
    end
 
    def @items.push(item)
      super
      "You added the item #{item} with push!"
    end
    super
  end
end
 
class TheClass
  include TheModule
end

x = TheClass.new
x.items   # => []
x.items << 'blue' # => You added the item 'blue' with <<!
x.items.push 'orange' # => You added the item 'orange' with push!
x.items # => ["blue", "orange"]