#

require 'rubygems'
require 'mechanize'

agent = WWW::Mechanize.new
stack = agent.get(ARGV[0]).links

while l = stack.pop
  p l.uri
  next unless l.uri.host == agent.history.first.uri.host
  stack.push(*(agent.click(l).links)) unless agent.visited? l.href
end

