# Kosher Bacon

Kosher Bacon allows tests written for MiniTest::Unit and Test::Unit to
run on [RubyMotion](http://www.rubymotion.com/), in both the simulator
and on device. Behind the scenes, test cases are converted to specs
that will be run by [MacBacon](https://github.com/alloy/MacBacon),
RubyMotion's built-in test framework.

## Status

Version 0.0.1

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

Write your tests in a test/unit style. For example:

```ruby
class TestBacon < MiniTest::Unit::TestCase

  def setup
    @bacon = Bacon.new
  end

  def test_is_kosher_after_processing
    @bacon.process
    assert_predicate @bacon, :kosher?
  end

end
```

## Compatibility

Assertions implemented:

* `assert`, `refute`
* `assert_empty`, `refute_empty`
* `assert_equal`, `assert_not_equal`, `refute_equal`
* `assert_in_delta`, `refute_in_delta`
* `assert_in_epsilon`, `refute_in_epsilon`
* `assert_includes`, `refute_includes`
* `assert_instance_of`, `refute_instance_of`
* `assert_kind_of`, `refute_kind_of`
* `assert_match`, `assert_no_match`, `refute_match`
* `assert_nil`, `assert_not_nil`, `refute_nil`
* `assert_operator`, `refute_operator`
* `assert_predicate`, `refute_predicate`
* `assert_raises`, `assert_raise`, `assert_nothing_raised`, `refute_raises`
* `assert_respond_to`, `refute_respond_to`
* `assert_same`, `assert_not_same`, `refute_same`
* `assert_send`, `assert_not_send`, `refute_send`
* `assert_throws`, `assert_nothing_thrown`, `refute_throws`
* `assert_block`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
