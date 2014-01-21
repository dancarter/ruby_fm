require 'spec_helper'

describe RubyFm::Track, :vcr do
  context 'searching' do
    it 'returns a list of relevant tracks' do
      track_name = 'Saint John'
      results = RubyFm::Track.search(track_name)

      expect(results.size).to_not eql(0)
      expect(results[0]).to be_kind_of(RubyFm::Track)
      expect(results[0].name).to eql(track_name)
      expect(results[0].mbid).to eql('b700456c-39d4-4ee8-bd5b-5a155139ce0d')
      expect(results[0].url).to eql('http://www.last.fm/music/Cold+War+Kids/_/Saint+John')
      expect(results[0].streamable).to eql({"#text"=>"1", "fulltrack"=>"0"})
      expect(results[0].artist).to eql('Cold War Kids')
      expect(results[0].listeners).to eql('208101')
    end
  end
end
