# frozen_string_literal: true

require_relative 'artascii/version'
require "mini_magick"

module Artascii
  class Image
    attr_reader :height, :width

    MAX_BRIGHTNESS = 255

    def initialize(path, resize_percent=100)
      @image = MiniMagick::Image.open(path)
      @height = @image.height
      @width = @image.width
      @matrix = @image.resize resize_percent
      self
    end

    def get_pixels
      @image.get_pixels
    end

    def get_brightness_mx(matrix)
      bright_mx = Array.new
      matrix.each do |line|
        line_mx = Array.new
        line.each { |pixel| line_mx.append(pixel.sum/pixel.length) }
        bright_mx.append(line_mx)
      end
      bright_mx
    end

    def get_ascii_mx(matrix)
      ascii_mx = Array.new
      matrix.each do |line|
        line_mx = Array.new
        line.each { |pixel| line_mx.append(to_char(pixel)) }
        ascii_mx.append(line_mx)
      end
      # print_mx(ascii_mx)
      ascii_mx
    end

    def modify_ascii_mx
      ascii_mx = Array.new
      @matrix.each do |line|
        line_mx = Array.new
        line.each { |pixel| yield }
        ascii_mx.append(line_mx)
      end
      ascii_mx
    end

    def print_to_file(matrix, path=nil)
      File.open(path, "w") do |f|
        matrix.each { |line| f.puts line.join() + '\n'}  
      end 
    end

    def to_char(brightness)
      char_s = "`^\",:;Il!i~+_-?][}{1)(|\\/tfjrxnuvczXYUJCLQ0OZmwqpdbkhao*#MW&8%B@$".freeze
      char_arr = char_s.split("")
      index = (brightness * char_arr.length)/MAX_BRIGHTNESS - 1
      char_arr[index] * 3
    end
  end
end
