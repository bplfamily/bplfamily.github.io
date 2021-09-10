require "jekyll"
require "liquid"

module Jekyll
  module RemoveFileExtension
    def remove_file_extension(str)
      return str.sub(/\.[A-Za-z]*$/, '')
    end
  end
end

Liquid::Template.register_filter(Jekyll::RemoveFileExtension)