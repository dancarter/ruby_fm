require 'faraday'
require 'json'

module RubyFm
  class Artist
    attr_reader :name

    def initialize(attributes)
      @name = attributes['name']
    end

    class << self
      def search(phrase)
        res = connection.get('/2.0/', {
          method: 'artist.search',
          artist: phrase,
          api_key: RubyFm.api_key,
          format: 'json'
        })
        parsed_results = JSON.parse(res.body)
        if parsed_results['results'] && parsed_results['results']['artistmatches']
          parsed_results['results']['artistmatches']['artist'].map do |artist_attributes|
            new(artist_attributes)
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
