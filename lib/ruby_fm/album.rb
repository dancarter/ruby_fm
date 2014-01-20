require 'faraday'
require 'json'

module RubyFm
  class Album
    attr_reader :name, :artist, :id, :url, :images, :streamable, :tracks, :mbid

    def initialize(attributes, tracks)
      @name = attributes['name']
      @artist = attributes['artist']
      @mbid = attributes['mbid']
      @id = attributes['id']
      @url = attributes['url']
      @streamable = attributes['streamable']
      @images = attributes['image'].map do |image|
        image['#text']
      end
      @tracks = tracks
    end

    class << self
      def search(phrase)
        res = connection.get('/2.0/', {
          method: 'album.search',
          album: phrase,
          api_key: RubyFm.api_key,
          format: 'json'
        })
        parsed_results = JSON.parse(res.body)
        if parsed_results['results'] && parsed_results['results']['albummatches']
          album_results = [parsed_results['results']['albummatches']['album']].flatten
          album_results.map do |album_attributes|
            tracks = get_tracks(album_attributes['name'],album_attributes['artist'])
            new(album_attributes, tracks)
          end
        else
          []
        end
      end

      protected
      def get_tracks(name, artist)
        res = connection.get('/2.0/', {
          method: 'album.getInfo',
          album: name,
          artist: artist,
          api_key: RubyFm.api_key,
          format: 'json'
        })
        parsed_results = JSON.parse(res.body)
        if parsed_results['album'] && parsed_results['album']['tracks']['track']
          tracks_results = [parsed_results['album']['tracks']['track']].flatten
          tracks_results.map do |track_attributes|
            Track.new(track_attributes)
          end
        else
          []
        end
      end

      def connection
        conn ||= Faraday.new(:url => 'http://ws.audioscrobbler.com') do |faraday|
          faraday.request  :url_encoded             # form-encode POST params
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
      end
    end
  end
end
