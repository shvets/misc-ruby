# airfare.rb

require 'rubygems'
require 'scrubyt'

url = 'http://travel.travelocity.com/flights/AirSearch.do?fo-from=JFK&fo-to=KBP&nav-fo=fo&fo-exact=exactDates&fo-fromdate=06/01/2009&fo-todate=08/01/2009&fo-fromtime=Anytime&fo-totime=Anytime&fo-adults=1&fo-minors=0&fo-seniors=0'

http://travel.travelocity.com/flights/AirSearch.do?leavingFrom=JFK&goingTo=KBP&flightType=roundtrip&tripType=aironly&leavingDateExact=06%2F01%2F2009&returningDateExact=08%2F01%2F2009&dateLeavingTime=Anytime&dateReturningTime=Anytime&fo-adults=1&fo-minors=0&fo-seniors=0

data = Scrubyt::Extractor.define do
  fetch url

#  record "//html/body/div[3]/div[1]/div[2]" do
  record '//html/body/div[@id="ultraWide "]' do

# /div[@id='ultraWide']/div[@id='mainContent']/div[@id='ñontent']/table[@id='tfGrid']/tr
    #item_name 'APPLE NEW IPOD MINI 6GB MP3 PLAYER SILVER'
    #price '$71.99'
  end
 # next_page 'Next >', :limit => 5
end

p data.to_xml