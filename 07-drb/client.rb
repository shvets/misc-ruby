require 'drb/drb'

DRb.start_service

math_service = DRbObject.new_with_uri("druby://localhost:3030")

sum=math_service.add(2,2)

puts "sum: " + sum.to_s