# get_music.rb

require 'rubygems'
require 'mechanize'
require 'yaml'
#require 'rutils'

class Spider
  LINKS_FILE_NAME = 'links.yml'

  def initialize url
    @url = url

    @agent = WWW::Mechanize.new
  end

  def spy
    build_links_file

    links = open(LINKS_FILE_NAME) {|f| YAML.load(f) }

    links.each do |link|
      load_files_from_page(link[0]) unless link[1]
    end

  end

  def build_links_file
    unless File::exist?(LINKS_FILE_NAME)
      page = @agent.get(@url)

      links = {}

      page.links.each do |link|
        links[link.href] = false if link.href =~ /^album.phtml/
      end 

      open(LINKS_FILE_NAME, "w") {|f| YAML.dump(links, f) }
    end
  end

  def load_files_from_page page_url
    #puts @url + "/" + page_url

    page = @agent.get(@url + "/" + page_url)

    $KCODE='n'

    page.root.xpath('//html/body/table/tr').each do |tr|
      list = tr.children.entries

      text1 = list[2].children.to_html
      text2 = list[6].children.first.to_s

      title = text1[1..text1.size]
#.to_a.pack('A*').translify

      #p text2

      #re1 = /\<td class="desc"\>(.*)\<\/td\>/
      re2 = /\<a href="(.*)"\><img/

      #title = text1.scan(re1)
      name = text2.scan(re2)[0][0]

      puts title
      puts name

      File.open("temp.txt", "w") {|f| f.write title }

      break
    end
  end

end


url = "http://mlmusic.38th.ru"

spider = Spider.new url

spider.spy



