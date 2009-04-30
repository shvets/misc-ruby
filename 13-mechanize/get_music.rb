# get_music.rb

require 'rubygems'
require 'mechanize'
require 'yaml'
require 'rutils'
require 'iconv'

require 'russify'


class String
  def blank?
    s_i = self.dup

    s_i == nil or s_i.strip.size == 0
  end
end

class Spider
  include Russify

  LINKS_FILE_NAME = 'links.yml'


  def initialize url
    @url = url

    @agent = WWW::Mechanize.new

    $KCODE='a'
  end

  def spy
    build_links_file

    begin
      links = load

      links.each do |link|
        key = link[0]
        values = link[1]
        name = values[:name]
        url = values[:url]
        visited = values[:visited]

        # create "name" folder

        load_files_from_page(url) unless visited

        values[:visited] = true
      end
    ensure
      save links
    end
  end

  def load
    open(LINKS_FILE_NAME) {|f| YAML.load(f) }
  end

  def save links
    open(LINKS_FILE_NAME, "w") {|f| YAML.dump(links, f) }
  end

  private 

  def build_links_file
    unless File::exist?(LINKS_FILE_NAME)
      page = @agent.get(@url)

      links = {}

      table = nil
      page.root.xpath('//html/body/table').each_with_index do |t, index|
        table = t
        break if index == 2
      end

      table.xpath('//tr').each do |tr|
        name, url = find_album_name_and_url(tr.children.entries)

        unless name.nil?
          if url =~ /^album.phtml/
            links[url] = {:visited => false, :name => name, :url => url}
          end
        end
      end

      save links
    end
  end

  def find_album_name_and_url list
    td = list[2]

    return ['', ''] if td.nil?

    text = td.children.first.to_s

    return ['', ''] if text.blank?

    re = /\<a href="(.*)">(.*)\<\/a>/

    result = text.scan(re)[0]

    return ['', ''] if result.nil?

    url = result[0]
    text = result[1]

    name = convert text

    return [name, url]
  end

  def load_files_from_page page_url
    #puts @url + "/" + page_url

    page = @agent.get(@url + "/" + page_url)

    i = 0
    page.root.xpath('//html/body/table/tr').each do |tr|
      name, url = find_song_name_and_url(tr.children.entries)

      break if url.nil?

      puts name
      puts url

      name.gsub!("'", "_")
      name.gsub!("\"", "_")
      File.new("1/" + name + '.mp3', "w")

      i = i + 1
      break if i == 2
    end
  end

  def find_song_name_and_url list
    td1 = list[2]
    td2 = list[6]

    return ['', ''] if td2.nil?

    text1 = td1.children.first.to_s
    text1 = text1[1..text1.size]

    text2 = td2.children.first.to_s

    name = ''

    text1.chars.each_with_index do |ch, index|
      #puts "#{ch} -- #{ch[0]}"                             
   
      name << convert_char(ch)
    end
                      
    re2 = /\<a href="(.*)"\><img/
    url = text2.scan(re2)[0][0]

    return [name, url]
  end

end

url = "http://mlmusic.38th.ru"

spider = Spider.new url

spider.spy
