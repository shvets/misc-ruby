

require 'sinatra'
require "slim"

get "/" do
  slim :index	
end

__END__

@@layout
doctype html
html
  head
    meta charset="utf8"
    title Test
  body
    == yield

@@index
h1 index


