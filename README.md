# RubyFm

Wrapper for using the Last FM API

## Installation

Add this line to your application's Gemfile:

`gem 'ruby_fm'`

And then execute:

`$ bundle`

Or install it yourself as:

`$ gem install ruby_fm`

## Usage

`artist = LastRubyFm::Artist.search('65daysofstatic').first
artist.name # '65daysofstatic'
artist.image # ''

album = LastRubyFm::Album.search('Robbers & Cowards')[1]
album.artist  # 'Cold War Kids'
album.tracks # retrieves a list of LastRubyFm::Track objects for the given album`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
