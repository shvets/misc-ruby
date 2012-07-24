# idea from here: http://railstech.com/2011/02/resize-image-using-gd2/

require 'rubygems'
require "image_size"
require "open-uri"
require 'gd2-ffij'

class ImageResizer
  include GD2
  
  def resize input_name, output_name, resized_width = 100, resized_height = 100
    image = Image.import(input_name)
    
    resize_image = image.resize(resized_width, resized_height, true)
    
    resize_image.export(output_name, {})  
  end
  
  def resize_with_ratio input_name, output_name, ratio
    image_size = imagesize input_name
    
    resized_width = image_size.width/ratio.to_i
    resized_height = image_size.height/ratio.to_i
    
    image = Image.import(input_name)

    resize_image = image.resize(resized_width, resized_height, true)

    resize_image.export(output_name, {})    
  end 
  
  private
  
  def imagesize file_name
    open(file_name, "rb") do |f|
      ImageSize.new(f.read)
    end
  end 
end


resizer = ImageResizer.new

if ARGV.size == 4
  resizer.resize(*ARGV)
elsif ARGV.size == 3
  resizer.resize_with_ratio(*ARGV)  
elsif ARGV.size < 3
  puts "Not enough parameters. Use 'ruby image-resizer.rb infile outfile width height'"
else

end

