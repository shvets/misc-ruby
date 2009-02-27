#

require 'soap/rpc/standaloneServer'
require 'interest_calculator'

NS = 'http://pragprog.com/InterestCalc'

class Server2 < SOAP::RPC::StandaloneServer

  def on_init
    calc = InterestCalculator.new

    add_method(calc, 'compound', 'principal', 'rate', 'freq', 'years')
    add_method(calc, 'call_count')
  end
end

svr = Server2.new('Calc', NS, '0.0.0.0', 12321)

trap('INT') { svr.shutdown }

svr.start