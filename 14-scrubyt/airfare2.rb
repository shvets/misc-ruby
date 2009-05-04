#

require 'rubygems'
require 'nokogiri'
require 'open-uri'


helper = Class.new do
  def regex node_set, attribute, value
    node_set.find_all { |node| node[attribute].strip == value }
  end
end.new

def clean name
  name.gsub(/\s|\$/, '').gsub(/\&#xA0;/, ' ')
end

# Get a Nokogiri::HTML:Document for the page we're interested in...

#doc = Nokogiri::HTML(open('http://www.google.com/search?q=tenderlove'))

flights = []

doc = Nokogiri::HTML(open('test.html'))

i = 0
doc.xpath('//table[@id="tfGrid"]/tr').each do |tr|
  flight = {}

  td1 = tr.xpath('./td[regex(., "class", "tfAirline")]', helper).first

  unless td1.nil? or td1.to_s =~ /javascript/
    flight[:airline] = td1.children[0].to_xml

    re = /\<div class=\"tfFlightNo\"\>(.*)\<\/div\>/

    flight[:flightno] = clean(td1.children[1].to_xml.scan(re)[0][0])

    td2 = tr.xpath('./td[regex(., "class", "tfDepart")]', helper).first
    flight[:departure] = clean(td2.children[0].to_xml)

    td3 = tr.xpath('./td[regex(., "class", "tfArrive")]', helper).first
    flight[:arrival] = clean(td3.children[0].to_xml)

    td4 = tr.xpath('./td[regex(., "class", "tfTime")]', helper).first
    flight[:time] = clean(td4.children[0].to_xml)

    td5 = tr.xpath('./td[regex(., "class", "tfPrice")]', helper).first
    flight[:price] = clean(td5.children[0].to_xml)

#    flight[:departure] = tr.xpath('./td[@class="tfDepart "]').inner_text
#    flight[:arrival] = tr.xpath('./td[@class="tfArrive "]').inner_text
#    flight[:time] = tr.xpath('./td[@class="tfTime "]').inner_text
#    flight[:price] = tr.xpath('./td[@class="tfPrice "]').inner_text

    flights << flight

    i = i + 1
  end

  #break if i == 2
end

p flights

__END__

<table id="tfGrid" cellspacing="0" cellpadding="0" border="0">
<tbody>
<tr>
<th class="tfSort" colspan="2"> Airline </th>
<th class="tfSort"> Departure Time </th>
<th class="tfSort"> Arrival Time </th>
<th class="tfSort"> Total Travel Time </th>
<th class="tfSort" colspan="3">
</th>
</tr>
<tr>
<td class="tfLogoMR" valign="top">
<div class="tfSymbol">
<img height="18" border="0" width="18" onerror="this.src='http://i.travelocity.com.edgesuite.net/legacy/graphics/1x1.gif';this.alt='';" alt="Aeroflot" src="http://i.travelocity.com.edgesuite.net/legacy/logos/ag_sulogo_3.gif"/>
</div>
</td>
<td class="tfAirline" valign="top">
Aeroflot
<div class="tfFlightNo">Flight 316 / 183 </div>
</td>
<td class="tfDepart" valign="top" rowspan="2">
8:30pm
<div class="tfDepAp">         
</div>
</td>
<td class="tfArrive" valign="top" rowspan="2">
</td>
<td class="tfTime" valign="top" rowspan="2">
</td>
<td class="tfPrice" align="center" valign="top" rowspan="2">
</td>
<td class="tfOrBlank" rowspan="2"> </td>
<td class="tfNotes" valign="top" rowspan="2">
</td>
</tr>