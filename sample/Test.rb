require_relative "../lib/asciiart"
require "mini_magick"

path = "/home/lovepreet/Downloads/ascii-pineapple.jpg"
image_mx = Asciiart::Image.new(path, "500x500")
puts "Successfully Loaded Image!"
puts "Image Size: #{image_mx.height} x #{image_mx.width}"

puts "Constructing Matrix of pixels..."
pixels = image_mx.get_pixels
# puts pixels.to_s
puts "successfully constructed pixel matrix!"
puts "Pixel Matrix Size: #{pixels.length} x #{pixels[0].length}"


puts "Constructing Brightness Matrix"
puts "Using average method"
bright_pixels = image_mx.get_brightness_mx(pixels)
puts "Brightness Pixel Matrix Size: #{bright_pixels.length} x #{bright_pixels[0].length}"

image_mx.get_ascii_mx(bright_pixels)
