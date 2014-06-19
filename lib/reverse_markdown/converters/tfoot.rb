module ReverseMarkdown
  module Converters
    class Tfoot < Base
      def convert(node)
        content = treat_children(node)
        content = content.gsub("|","").gsub!(/\n^\s*\n/, "\n")
          "\n#{content}"
      end
    end
    register :tfoot, Tfoot.new
  end
end
