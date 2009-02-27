#

require 'soap/rpc/driver'

proxy = SOAP::RPC::Driver.new("http://localhost:12321", "http://pragprog.com/InterestCalc")

proxy.add_method('compound', 'principal', 'rate', 'freq', 'years')
proxy.add_method('call_count')

puts "Call count: #{proxy.call_count}"
puts "5 years, compound annually: #{proxy.compound(100, 0.06, 1, 5)}"
puts "5 years, compound monthly: #{proxy.compound(100, 0.06, 12, 5)}"
puts "Call count: #{proxy.call_count}"