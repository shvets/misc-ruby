require 'rubygems'
require 'httparty'

class RubyGemsApi
  include HTTParty
  base_uri 'rubygems.org'

  def self.info_for(gems)
    res = get('/api/v1/dependencies', :query => { :gems => gems })
    Marshal.load(res)
  end

  def self.display_info_for(gems)
    info_for(gems).each do |info|
      puts "#{info[:name]} version #{info[:number]} dependencies: #{info[:dependencies].inspect}"
    end
  end
end

RubyGemsApi.display_info_for(ARGV[0])