#

require 'rubygems'
require 'scrubyt'

# class Album
#   attr_accessor :name, :url
# 
#   def initialize(property)
#     @name = (property/:mls).inner_html
#     @url = (property/:list_price).inner_html
#   end
# end

module Russify
  MAPPING = {
          192 => 46, 193 => -33, 194 => -33, 195 => 35, 196 => -32, 197 => -32,
          198 => 30, 199 => -36, 200 => 29,
          201 => -33, 202 => -33, 203 => -33, 204 => -33, 205 => -33, 206 => -33, 207 => -33,
          208 => -33, 209 => 30, 210 => 14,
          211 => 14, 212 => 14, 213 => 14, 214 => -48, 215 => -53, 216 => 20, 217 => 18,
          218 => -51, 219 => 13, 219 => 13, 220 => -63,
          221 => 12, 222 => 9, 223 => 0, 224 => -66, 225 => -97, 226 => -97, 227 => -77,
          228 => -96, 229 => -96, 230 => 0,
          231 => -100, 232 => -83, 233 => -97, 234 => 0, 235 => -97, 236 => -98, 237 => -97,
          238 => -97, 239 => -97, 240 => -97,
          241 => -82, 242 => -98, 243 => -98, 244 => -98, 245 => -98, 246 => -112, 247 => -117,
          248 => 0, 249 => 0, 250 => -115,
          251 => -99, 252 => -95, 253 => -100, 254 => -103
  }


  TABLE = {
          160 => "a", 161 => "b", 162 => "v", 163 => "g", 164 => "d", 165 => "e", 166 => "zh", 167 => "z",
          168 =>  "i", 169 => "y", 170 => "k", 171 => "l", 172 => "m", 173 => "n", 174 => "o", 175 => "p",
          224 => "r", 225 => "s", 226 => "t", 227 => "u", 228 => "f", 229 => "h", 230 => "c", 231 => "ch",
          232 => "sh", 233 => "s'h", 234 => "''", 235 => "yi", 236 => "'", 237 => "ye", 238 => "yu", 239 => "ya",
          '' => "yo",
          '' => "YO",
          128 => "A", 129 => "B", 130 => "V", 131 => "G", 132 => "D", 133 => "E", 134 => "Zh", 135 => "Z",
          136 => "I", 137 => "Y", 138 => "K", 139 => "L", 140 => "M", 141 => "N", 142 => "O", 143 => "P", 144 => "R",
          145 => "S", 146 => "T", 147 => "U", 148 => "F", 149 => "H", 150 => "C", 151 => "Ch", 152 => "Sh",
          153 => "S'h", 154 => "''", 155 => "Yi", 156 => "'", 157 => "Ye", 158 => "Yu", 159 => "Ya"
  }

  def convert_char ch
    new_ch = ''

    diff = MAPPING[ch[0]]

    if diff.nil?
      if ch[0] == 112
        new_ch = 'r'
      else
        new_ch = ch
      end
    else
      ch1 = ch[0] + diff
      ch2 = TABLE[ch1]
      new_ch = (ch2.nil? ? ch1 : ch2)
    end

    new_ch
  end

  def convert old_name
    new_name = ''

    old_name.chars.each do |ch|
#      puts "#{ch} -- #{ch[0]}"                             
   
      new_name << convert_char(ch) rescue puts "error: #{ch}"
    end

    new_name
  end

end

class Spider
  include Russify

  LINKS_FILE_NAME = 'links.yml'


  def initialize url
    @url = url

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

        load_files_from_page(name, url) unless visited

        #values[:visited] = true
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
      url = "http://mlmusic.38th.ru"
      links = {}

      data = Scrubyt::Extractor.define do
        fetch url

        entry '//html/body/table[2]/tr' do
          name "/td[3]"
#, :format_output => lambda {|x| x.nil? ? '' : convert(x) }
          url "/td[3]/a/@href", :format_output => lambda {|x| url + '/' + x }

          # url "//h2/a/@href", :format_output => lambda {|x| url + x }
          # blog_title "//h2/a"
          # blog_author_id "//ul/li/a[@class='blog_usernames_blog']/@href", :format_output => lambda {|x| x.split('/')[2]}
          # blog_author "//ul/li/a[@class='blog_usernames_blog']", :format_output => lambda {|x| x.split('&')[0]}
          # blog_date "//span/abbr", :format_output => lambda {|x| x.split(' ')[1]}
          # number_of_reads "//span[@class='statistics_counter']", :format_output => lambda {|x| x.split(' ')[0]}
        end

        #next_page "//a[@title='Go to next page']", :limit => 1
      end

      data.to_hash.each do |entry|
        links[entry[:url]] = {:visited => false, :name => convert(entry[:name]), :url => entry[:url]}
      end

      save links
    end
  end

  def load_files_from_page dir_name, page_url
    data = Scrubyt::Extractor.define do
      fetch page_url

      entry '//html/body/table[1]/tr' do
        name "/td[2]"
        url "/td[4]", :format_output => lambda {|x| p x; x }
      end
    end

    p data.to_xml

    #data.to_hash.each do |entry|
    #  p entry
      #links[entry[:url]] = {:visited => false, :name => convert(entry[:name]), :url => entry[:url]}
    #  retrieve_file dir_name, correct_name(convert(entry[:name]) + '.mp3') unless entry[:name].nil?
    #end
  end

  def retrieve_file dir_name, file_name
    File.new("1/" + file_name, "w")
  end

  def correct_name name
    name.gsub("'", "_").gsub("\"", "_")
  end
end

url = "http://mlmusic.38th.ru"

spider = Spider.new url

spider.spy
