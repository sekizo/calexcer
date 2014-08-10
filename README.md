# Calexcer

Convert excel sheet to object as calendar.

## Installation

Add this line to your application's Gemfile:

    gem 'calexcer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install calexcer

## Usage

    require "calexcer"
    Calexcer::Book.new("PATH/TO/excel.xls").sheets[0].vertical.to_hash
    # => { "2014-08-06" => ["some event 1", "some event 2"], "2014-08-31" => ["some event on the day", "final day event"] }


## Contributing

1. Fork it ( https://github.com/[my-github-username]/calexcer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
