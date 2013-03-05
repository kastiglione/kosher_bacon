# kosher_bacon

kosher_bacon is an adaptor that converts test written for
MiniTest::Unit (and Test::Unit) into specs that can be run by
[MacBacon](https://github.com/alloy/MacBacon) on
[RubyMotion](http://www.rubymotion.com/)

## Installation

For apps using Bundler:

    gem 'kosher_bacon'

And then execute:

    $ bundle

For apps without Bundler, install the gem by hand:

    $ gem install kosher_bacon

And then update your Rakefile like so:

    require 'kosher_bacon'

## Usage

Write your tests in a test/unit style. For learning how to do this,
feel free to start with the links below, if you trust this README. If
your eyes slanted as you read the word "trust", enjoy your upcoming
search engine time.

[WikiBooks: Ruby Programming/Unit testing](http://en.wikibooks.org/wiki/Ruby_Programming/Unit_testing)
[A Guide to Testing Rails Applications, Unit Testing your Models](http://guides.rubyonrails.org/testing.html)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
