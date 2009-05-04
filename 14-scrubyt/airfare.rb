# airfare.rb

require 'rubygems'
require 'scrubyt'

data = Scrubyt::Extractor.define do
  fetch 'http://travelocity.com'

  fill_textfield 'fo-from', 'JFK'
  fill_textfield 'fo-to', 'KBP'

  fill_textfield 'nav-fo', 'fo'
  fill_textfield 'fo-exact', 'exactDates'
  fill_textfield 'fo-fromdate', '06/01/2009' # mm-dd-yyyy
  fill_textfield 'fo-todate', '08/01/2009'

  fill_textfield 'fo-fromtime', 'Anytime'
  fill_textfield 'fo-totime', 'Anytime'

  fill_textfield 'fo-adults', '1'
  fill_textfield 'fo-minors', '0'
  fill_textfield 'fo-seniors', '0'

  submit
  #click_link 'Apple iPod'
  
  record do
    #item_name 'APPLE NEW IPOD MINI 6GB MP3 PLAYER SILVER'
    #price '$71.99'
  end
 # next_page 'Next >', :limit => 5
end

p data.to_xml