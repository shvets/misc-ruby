require 'rubygems'
require 'scrubyt'

ebay_data = Scrubyt::Extractor.define do
  fetch 'http://www.ebay.com/'
  fill_textfield 'satitle', 'ipod'
  submit
  click_link 'Apple iPod'
  
  record do
    item_name 'APPLE NEW IPOD MINI 6GB MP3 PLAYER SILVER'
    price '$71.99'
  end
  next_page 'Next >', :limit => 5
end