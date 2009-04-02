handle_exception_aspect = lambda do |object, method, *params|
  begin
    object.send method, *params
  rescue Exception => e
    p e
    #raise e
  end 
end

def wrap_class_with_aspect clazz, methods_to_wrap, &aspect
  
  handler_class = Class.new {
    @clazz = clazz
    @methods_to_wrap = methods_to_wrap    
  }
  
  handler_class.instance_eval do
    metaclass = class << self; self; end     
    
    methods_to_wrap.each do |method|    
      metaclass.send :define_method, method do |*params|
        aspect.call @clazz, method, *params
      end
    end
  end
  
  handler_class
end

def wrap_instance_with_aspect clazz, methods_to_wrap, &aspect      
  instance = clazz.new
  
  instance.extend to_module clazz, methods_to_wrap, &aspect
  
  instance
end

def to_module clazz, methods_to_wrap, &aspect
  orig_instance = clazz.new
  
  Module.new do
    methods_to_wrap.each do |method|
      define_method method do |*params|
        aspect.call orig_instance, method, *params
      end
    end
  end
end

class Test
  def self.class_test
    puts "Original class method test call..."
    raise "exception..."
  end
  
  def instance_test
    puts "Original instance method test call..."
    raise "exception..."
  end  
end
    
MyTest = wrap_class_with_aspect(Test, [:class_test], &handle_exception_aspect)
MyTest.class_test

my_test = wrap_instance_with_aspect(Test, [:instance_test], &handle_exception_aspect)
my_test.instance_test

