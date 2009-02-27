class InterestCalculator
attr_reader :call_count
def initialize
@call_count = 0
end
def compound(principal, rate, freq, years)
@call_count += 1
principal*(1.0 + rate/freq)**(freq*years)
end
end
