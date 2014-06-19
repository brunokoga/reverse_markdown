module ReverseMarkdown
  module Converters
    class Caption < Base
      def convert(node)
          "[#{content}]"
      end
    end
    register :caption, Caption.new
  end
end
