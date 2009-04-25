#

require 'rubygems'
require 'mechanize'

class TestMech < WWW::Mechanize
  def process
    get 'http://rubyforge.org/'
    search_form = page.forms.first
    search_form.words = 'WWW'
    submit search_form

    page.links_with(:href => %r{/projects/} ).each do |link|
      next if link.href =~ %r{/projects/support/}

      puts 'Loading %-30s %s' % [link.href, link.text]
      begin
        transact do
          click link
          # Do stuff, maybe click more links.
        end
        # Now we're back at the original page.

      rescue => e
        $stderr.puts "#{e.class}: #{e.message}"
      end
    end
  end
end

TestMech.new.process

