# Run this file with `RAILS_ENV=production rackup -p 3000 -s thin`
# Be sure to have rails and thin installed.
require "rubygems"

# We are not loading Active Record, nor the Assets Pipeline, etc.
# This could also be in your Gemfile.
gem "actionpack", "~> 3.2"
gem "railties",   "~> 3.2"

require "rails"
require "action_controller/railtie"

class MyApp < Rails::Application
  routes.append do
    match "/hello/world" => "hello#world"
  end

  # Here you could remove some middlewares, for example,
  # Rack::Lock, AD::Flash and AD::BestStandardsSupport below.
  # The remaining stack is printed on rackup. Rails 4 will
  # have a config.middleware.clear for those wishing a clear slate.
  config.middleware.delete "Rack::Lock"
  config.middleware.delete "ActionDispatch::Flash"
  config.middleware.delete "ActionDispatch::BestStandardsSupport"

  # We need a secret token for session, cookies, etc.
  config.secret_token = "49837489qkuweoiuoqwehisuakshdjksadhaisdy78o34y138974xyqp9rmye8yrpiokeuioqwzyoiuxftoyqiuxrhm3iou1hrzmjk"
end

# This is a barebone controller. Include the modules you want, more info here:
# http://piotrsarnacki.com/2010/12/12/lightweight-controllers-with-rails3/
class HelloController < ActionController::Metal
  include ActionController::Rendering

  def world
    render :text => "Hello world!"
  end
end

# Initialize the app
MyApp.initialize!

# Print the stack for fun!
puts ">> Starting Rails lightweight stack"
Rails.configuration.middleware.each do |middleware|
  puts "use #{middleware.inspect}"
end
puts "run #{Rails.application.class.name}.routes"

# Run it!
run MyApp