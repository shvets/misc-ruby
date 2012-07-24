require 'stringio'

local_gems = StringIO.new `gem list`

while line = local_gems.gets do
  name = line.scan(/(\w*)\s(.*)/)[0][0]
    
  p name
    
  p `gem dependency #{name}`
end
