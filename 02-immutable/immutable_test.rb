# immutable.rb

require 'rubygems'
require 'lib/immutable'


module Foo
  include Immutable

  def foo
    :foo
  end

  immutable_method :foo, :silent => true
end

module Foo
  def foo
    :fooooooo
  end
end

include Foo

puts foo          # => :foo

module Bar
  include Immutable

  def bar
    :bar
  end

  immutable_method :bar
end

include Bar

begin
  module Bar
    def bar
      :barrrrrr # => exception: Immutable::CannotOverrideMethod
    end
  end
rescue Immutable::CannotOverrideMethod => error
  puts "Got error: " + error
end

