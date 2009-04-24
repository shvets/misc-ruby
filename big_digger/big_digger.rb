# big_digger.rb

require 'rubygems'

require 'webrat'
require 'webrat/core/locators'

class BigDigger
  include Webrat::Methods
  include Webrat::Locators

  def initialize(url)
    @url = url

    Webrat.configure do |config|
      config.mode = :mechanize
    end
  end

  def dig
    visit @url

    #p self.methods.sort
    #p self.webrat_session.elements

    #p current_dom


#    locator = LinkLocator.new(webrat_session, current_dom, /(.)*album.phtml(.)*/)
#    p locator.locate

  end
end

url = "http://mlmusic.38th.ru"

digger = BigDigger.new url

digger.dig
