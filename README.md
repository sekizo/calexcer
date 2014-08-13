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
    book = Calexcer::Book.new("PATH/TO/excel.xls")  # => Calexcer::Book
    sheet = book.sheets[0]                          # => Calexcer::Sheet
    v_sheet = sheet.vertical_sheet                  # => Calexcer::VerticalSheet

    v_sheet.to_hash
    # => { date_1 => ["some event 1", "some event 2"], date_2 => ["some event on the day", "final day event"] }

    v_sheet.to_hashr
    # => { "repeat event 1" => [date_1, date_2, ...], "repeat event 2" => [date_2, date_3, ...] }

## Contributing

1. Fork it ( https://github.com/sekizo/calexcer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
