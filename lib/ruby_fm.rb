require "ruby_fm/version"
require "ruby_fm/artist"

module RubyFm
  def self.api_key=(key)
    @api_key = key
  end

  def self.api_key
    @api_key
  end
end
