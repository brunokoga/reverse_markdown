module ReverseMarkdown
  module Converters
    class Thead < Base
      def convert(node)
        content = treat_children(node)
          "\n#{content}"
      end
    end
    register :thead, Thead.new
  end
end
