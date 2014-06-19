module ReverseMarkdown
  module Converters
    class Sup < Base
      def convert(node)
        content = treat_children(node)
        if content.strip.empty? || already_superscript?(node) || inside_tfoot?(node)
          content
        else
          content.tr('0-9','⁰-⁹')
        end
      end

      def already_superscript?(node)
        node.ancestors('sup').size > 0
      end
      def inside_tfoot?(node)
        node.ancestors('tfoot').size > 0
      end
    end
    register :sup, Sup.new
  end
end
