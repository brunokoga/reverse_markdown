require 'digest'
require 'nokogiri'
require 'reverse_markdown/version'
require 'reverse_markdown/errors'
require 'reverse_markdown/cleaner'
require 'reverse_markdown/config'
require 'reverse_markdown/converters'
require 'reverse_markdown/converters/base'
require 'reverse_markdown/converters/a'
require 'reverse_markdown/converters/blockquote'
require 'reverse_markdown/converters/br'
require 'reverse_markdown/converters/bypass'
require 'reverse_markdown/converters/caption'
require 'reverse_markdown/converters/code'
require 'reverse_markdown/converters/del'
require 'reverse_markdown/converters/div'
require 'reverse_markdown/converters/drop'
require 'reverse_markdown/converters/em'
require 'reverse_markdown/converters/h'
require 'reverse_markdown/converters/hr'
require 'reverse_markdown/converters/img'
require 'reverse_markdown/converters/li'
require 'reverse_markdown/converters/ol'
require 'reverse_markdown/converters/p'
require 'reverse_markdown/converters/pass_through'
require 'reverse_markdown/converters/pre'
require 'reverse_markdown/converters/strong'
require 'reverse_markdown/converters/sup'
require 'reverse_markdown/converters/table'
require 'reverse_markdown/converters/td'
require 'reverse_markdown/converters/text'
require 'reverse_markdown/converters/tfoot'
require 'reverse_markdown/converters/thead'
require 'reverse_markdown/converters/tr'

module ReverseMarkdown

  def self.convert(input, options = {})
    root = case input
      when String                  then Nokogiri::HTML(input).root
      when Nokogiri::XML::Document then input.root
      when Nokogiri::XML::Node     then input
    end

    root or return ''
    config.apply(options)
    result = ReverseMarkdown::Converters.lookup(root.name).convert(root)
    config.reset
    cleaner.tidy(result)
  end

  def self.config
    @config ||= Config.new
    yield @config if block_given?
    @config
  end

  def self.cleaner
    @cleaner ||= Cleaner.new
  end

end
