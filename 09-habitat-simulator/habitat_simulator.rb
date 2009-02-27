# habitat_simulator.rb
# Gives idea on how has_many, belongs_to in rails are implemented

class CompositeBase
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.member_of(composite_name)
    attr_name = "parent_#{composite_name}"
    raise 'Method redefinition' if instance_methods.include?(attr_name)

    code = %Q{
      attr_accessor :#{attr_name}
    }

    class_eval(code)
  end

  def self.composite_of(composite_name)
    member_of composite_name

    code = %Q{
      def sub_#{composite_name}s
        @sub_#{composite_name}s = [] unless @sub_#{composite_name}s
        @sub_#{composite_name}s
      end

      def add_sub_#{composite_name}(child)
        return if sub_#{composite_name}s.include?(child)
        sub_#{composite_name}s << child
        child.parent_#{composite_name} = self
      end

      def delete_sub_#{composite_name}(child)
        return unless sub_#{composite_name}s.include?(child)
        sub_#{composite_name}s.delete(child)
        child.parent_#{composite_name} = nil
      end
    }

    class_eval(code)
  end

  def member_of_composite?(object, composite_name)
    object.respond_to?("parent_#{composite_name}")
  end

  #def member_of_composite?(object, composite_name)
  #  public_methods = object.public_methods
  #  public_methods.include?("parent_#{composite_name}")
  #end

  def to_s
    @name
  end
end

class Tiger < CompositeBase
  member_of(:population)
  member_of(:classification)
  # Lots of code omitted . . .
end

class Tree < CompositeBase
  member_of(:population)
  member_of(:classification)
  # Lots of code omitted . . .
end

class Jungle < CompositeBase
  composite_of(:population)
  # Lots of code omitted . . .
end

class Species < CompositeBase
  composite_of(:classification)
  # Lots of code omitted . . .
end

tony_tiger = Tiger.new('tony')

se_jungle = Jungle.new('southeastern jungle tigers')
se_jungle.add_sub_population(tony_tiger)

puts tony_tiger.parent_population # Should be the southeastern jungle

species = Species.new('P. tigris')
species.add_sub_classification(tony_tiger)

puts tony_tiger.parent_classification # Should be P. tigris
