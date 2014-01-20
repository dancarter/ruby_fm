require 'spec_helper'

describe RubyFm::Artist, :vcr do
  context 'searching' do
    it 'returns a list of relevant artists' do
      artist_name = '65daysofstatic'
      results = RubyFm::Artist.search(artist_name)

      images = ["http://userserve-ak.last.fm/serve/34/46404977.jpg",
                "http://userserve-ak.last.fm/serve/64/46404977.jpg",
                "http://userserve-ak.last.fm/serve/126/46404977.jpg",
                "http://userserve-ak.last.fm/serve/252/46404977.jpg",
                "http://userserve-ak.last.fm/serve/_/46404977/65daysofstatic+4312266316_916a42bda8.jpg"]

      expect(results.size).to_not eql(0)
      expect(results[0]).to be_kind_of(RubyFm::Artist)
      expect(results[0].name).to eql(artist_name)
      expect(results[0].listeners).to eql('436704')
      expect(results[0].mbid).to eql('0cd12ab3-9628-45ef-a97b-ff18624f14a0')
      expect(results[0].url).to eql('http://www.last.fm/music/65daysofstatic')
      expect(results[0].streamable).to eql('1')
      expect(results[0].images).to eql(images)
    end
  end
end
