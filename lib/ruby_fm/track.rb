require 'json'

module RubyFm
  class Track
    attr_reader :name, :duration, :mbid, :url, :streamable, :artist, :rank, :image, :listeners

    def initialize(attributes)
      @name = attributes['name']
      @duration = attributes['duration']
      @mbid = attributes['mbid']
      @url = attributes['url']
      @streamable = attributes['streamable']
      @artist = attributes['artist']['name'].nil? ? attributes['artist'] : attributes['artist']['name']
      @rank = attributes['@attr']['rank'] unless attributes['@attr'].nil?
      @listeners = attributes['listeners']
      if attributes['image']
        @images = attributes['image'].map do |image|
          image['#text']
        end
      end
    end

    class << self
      def search(phrase)
        res = connection.get('/2.0/', {
          method: 'track.search',
          track: phrase,
          api_key: RubyFm.api_key,
          format: 'json'
        })
        parsed_results = JSON.parse(res.body)
        if parsed_results['results'] && parsed_results['results']['trackmatches']
          track_results = [parsed_results['results']['trackmatches']['track']].flatten
          track_results.map do |track_attributes|
            new(track_attributes)
          end
        else
          []
        end
      end

      protected
      def connection
        conn ||= Faraday.new(:url => 'http://ws.audioscrobbler.com') do |faraday|
          faraday.request  :url_encoded             # form-encode POST params
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
      end
    end
  end
end
