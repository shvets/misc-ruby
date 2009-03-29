require 'spec'
require 'firewatir'

BROWSER = FireWatir::Firefox.new
PAGES = {
  'Google Homepage' => 'http://google.com'
}

Given /^that I am on the (.*)$/ do |page|
  BROWSER.goto PAGES[page]
end

When /^I search for (.*)$/ do |query|
  BROWSER.text_filed(:name, 'q').set(query)
  BROWSER.button(:name, 'btnG').click
end

Then /^I should see "([^\"]*)"$/ do |text|
  BROWSER.html_include?(text).should == true
end
