# test-recipe.rb
# Link: http://nealford.com/downloads/conferences/canonical/Neal_Ford-Building_DSLs_in_Static_and_Dynamic_Languages-handouts.pdf


class Ingredient
  def initialize(name)
    @name = name
  end

  attr_writer :quantity

  def to_s
    "#{@name}(#{@quantity})"
  end
end


# Open class
class Numeric
  def gram
    self
  end

  alias_method :grams, :gram

  def pound
    self * 453.59237
  end

  alias_method :pounds, :pound
  alias_method :lb, :pound
  alias_method :lbs, :pound

  def of name
    ingredient = Ingredient.new(name)

    ingredient.quantity = self

    ingredient
  end
end

class Recipe
  def initialize(name)
    @name = name
    @ingredients = []
  end
  
  def add ingredient
   @ingredients << ingredient
  end

  def consists_of &block
    instance_eval &block
  end

  def to_s
    "Recipe { name: #{@name}, ingredients: [ #{@ingredients.join(', ')} ]}"
  end
end


# test

recipe1 = Recipe.new "Spicy Bread"

recipe1.add 200.grams.of "Flour"
recipe1.add 1.lb.of "Nutmeg"

puts "recipe1: " + recipe1.to_s

recipe2 = Recipe.new "Milky Gravy"

recipe2.consists_of {
  add 1.lb.of "Flour"
  add 200.grams.of "Milk"
  add 1.gram.of "Nutmeg"
}

puts "recipe2: " + recipe2.to_s

