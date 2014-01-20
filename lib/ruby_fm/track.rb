require 'json'

module RubyFm
  class Track
    attr_reader :name, :duration, :mbid, :url, :streamable, :artist, :rank

    def initialize(attributes)
      @name = attributes['name']
      @duration = attributes['duration']
      @mbid = attributes['mbid']
      @url = attributes['url']
      @streamable = attributes['streamable']
      @artist = attributes['artist']['name']
      @rank = attributes['@attr']['rank']
    end
  end
end
