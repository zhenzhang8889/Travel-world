require 'rubygems'
require 'RMagick'
include Magick

module Paperclip
  class Chop < Paperclip::Processor
    def initialize(file, options = {}, attachment = nil)
      super

      geometry             = options[:geometry] # this is not an option
      @file                = file
      @crop                = geometry[-1,1] == '#'
      @target_geometry     = (options[:string_geometry_parser] || Geometry).parse(geometry)
      @current_geometry    = (options[:file_geometry_parser] || Geometry).from_file(@file)
      @source_file_options = options[:source_file_options]
      @convert_options     = options[:convert_options]
      @whiny               = options[:whiny].nil? ? true : options[:whiny]
      @format              = options[:format]
      @animated            = options[:animated].nil? ? true : options[:animated]

      @source_file_options = @source_file_options.split(/\s+/) if @source_file_options.respond_to?(:split)
      @convert_options     = @convert_options.split(/\s+/)     if @convert_options.respond_to?(:split)

      @current_format      = File.extname(@file.path)
      @basename            = File.basename(@file.path, @current_format)

      @profile = @attachment.instance
    end

    def make
      if @profile.need_chop
        return self.do_chop
      else
        @file
      end
    end

    def do_chop
      ratio = options[:c_ratio] || 1

      x = (@profile.chop_x.to_i * ratio).round
      y = (@profile.chop_y.to_i * ratio).round
      w = (@profile.chop_w.to_i * ratio).round
      h = (@profile.chop_h.to_i * ratio).round

      img = ::Magick::Image.read(@file.path)[0]
      chopped = img.crop(x, y, w, h)
      tmp_file = Tempfile.new([@basename, @format ? ".#{@format}" : ''])
      chopped.write(tmp_file.path)
      tmp_file
    end
  end
end