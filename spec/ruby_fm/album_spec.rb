require 'spec_helper'

describe RubyFm::Album, :vcr do
  context 'searching' do
    it 'returns a list of relevant albums' do
      album_name = 'Robbers & Cowards'
      results = RubyFm::Album.search(album_name)

      images = ["http://userserve-ak.last.fm/serve/34s/9197957.jpg",
                "http://userserve-ak.last.fm/serve/64s/9197957.jpg",
                "http://userserve-ak.last.fm/serve/126/9197957.jpg",
                "http://userserve-ak.last.fm/serve/300x300/9197957.jpg"]

      expect(results.size).to_not eql(0)
      expect(results[0]).to be_kind_of(RubyFm::Album)
      expect(results[0].name).to eql(album_name)
      expect(results[0].artist).to eql('Cold War Kids')
      expect(results[0].id).to eql('3251702')
      expect(results[0].mbid).to eql('1cd89dd6-158f-43c8-8a36-70546defb4a9')
      expect(results[0].url).to eql('http://www.last.fm/music/Cold+War+Kids/Robbers+&+Cowards')
      expect(results[0].images).to eql(images)
      expect(results[0].streamable).to eql('1')
    end
  end

  context 'get tracks' do
    it 'returns a list of tracks for the album' do
      album_name = 'Robbers & Cowards'
      album = RubyFm::Album.search(album_name)[0]

      expect(album.tracks[0]).to be_kind_of(RubyFm::Track)
      expect(album.tracks.size).to_not eql(0)
    end
  end
end
