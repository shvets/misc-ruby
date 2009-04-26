# get_music.rb

require 'rubygems'
require 'mechanize'
require 'yaml'
require 'rutils'
require 'iconv'

class Spider
  LINKS_FILE_NAME = 'links.yml'

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
    251 => -99, 252 => -95, 253 => 0, 254 => -103
  }


  TABLE = {
    160 => "a", 161 => "b", 162 => "v", 163 => "g", 164 => "d", 165 => "e", 166 => "zh", 167 => "z",
    168 =>  "i", 169 => "y", 170 => "k", 171 => "l", 172 => "m", 173 => "n", 174 => "o", 175 => "p",
    177 => "r",
    225 => "s", 226 => "t", 227 => "u", 228 => "f", 229 => "h", 230 => "c", 231 => "ch", 232 => "sh", 233 => "s'h", 
    234 => "''", 235 => "yi", 236 => "'", 237 => "ye", 238 => "yu", 239 => "ya",
    '' => "yo",
    '' => "YO",                                                 
    128 => "A", 129 => "B", 130 => "V", 131 => "G", 132 => "D", 133 => "E", 134 => "Zh", 135 => "Z", 
    136 => "I", 137 => "Y", 138 => "K", 139 => "L", 140 => "M", 141 => "N", 142 => "O", 143 => "P", 144 => "R",
    145 => "S", 146 => "T", 147 => "U", 148 => "F", 149 => "H", 150 => "C", 151 => "Ch", 152 => "Sh", 
    153 => "S'h", 154 => "''", 155 => "Yi", 156 => "'", 157 => "Ye", 158 => "Yu", 159 => "Ya"
  }

  def initialize url
    @url = url

    @agent = WWW::Mechanize.new

    $KCODE='a'
  end

  def spy
    build_links_file

    begin
      links = open(LINKS_FILE_NAME) {|f| YAML.load(f) }

      links.each do |link|
        #load_files_from_page(link[0]) unless link[1]

        #links[link[0]] = true
      end
    ensure
      save_links links
    end
  end

  def build_links_file
    unless File::exist?(LINKS_FILE_NAME)
      page = @agent.get(@url)

      links = {}

      #page.links.each do |link|
      #  links[link.href] = false if link.href =~ /^album.phtml/
      #end 

      table = nil
      page.root.xpath('//html/body/table').each_with_index do |t, index|
        table = t
        break if index == 2
      end

      table.xpath('//tr').each do |tr|
        title, name = find_album_title_and_name(tr.children.entries)

        break if name.nil?

        puts title
        puts name
      end


      save_links links
    end
  end

  def save_links links
    open(LINKS_FILE_NAME, "w") {|f| YAML.dump(links, f) }
  end

  def load_files_from_page page_url
    #puts @url + "/" + page_url

    page = @agent.get(@url + "/" + page_url)

    i = 0
    page.root.xpath('//html/body/table/tr').each do |tr|
      title, name = find_song_title_and_name(tr.children.entries)

      break if name.nil?

      puts title
      puts name

      title.gsub!("\"", "_")
      File.new("1/" + title + '.mp3', "w")

      i = i + 1
      break if i == 2
    end
  end

  def find_album_title_and_name list
    td = list[3]

    return ['', ''] if td.nil?

    text = td.children.first.to_s

puts "text: #{td.children.first}"
    title = ''
    name = ''

    #text.chars.each_with_index do |ch, index|
    #  puts "#{ch} -- #{ch[0]}"                             
   
    #  title << convert_char(ch)
    #end
                      
#    re = /\<a href="(.*)"\><img/
#<td><a href="album.phtml?id=44">�+TL++-T ���+LT�, "�+L+�", 1979 (LP, �60 13241, 1979)</a></td>
#    name = text.scan(re2)[0][0]

    return [title, name]
  end

  def find_song_title_and_name list
    td1 = list[2]
    td2 = list[6]

    return ['', ''] if td2.nil?

    text1 = td1.children.first.to_s
    text1 = text1[1..text1.size]

    text2 = td2.children.first.to_s

    title = ''

    text1.chars.each_with_index do |ch, index|
      puts "#{ch} -- #{ch[0]}"                             
   
      title << convert_char(ch)
    end
                      
    re2 = /\<a href="(.*)"\><img/
    name = text2.scan(re2)[0][0]

    return [title, name]
  end

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
end


url = "http://mlmusic.38th.ru"

spider = Spider.new url

spider.spy
