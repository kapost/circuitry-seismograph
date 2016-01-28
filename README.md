# circuitry-seismograph

Adds [circuitry](https://github.com/kapost/circuitry) publisher & subscriber middlewares for
tracking message processing via [DataDog](https://www.datadoghq.com/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'circuitry-seismograph'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install circuitry-seismograph

## Usage

By default, this will track to DataDog within the `<app_name>.circuitry.publisher` and
`<app_name>.circuitry.subscriber` metric key/namespace when publishing or subscribed to receive
messages, respectively. You can override these options by providing custom `:namespace` (required)
and `:stat` (optional) options to the middleware entry. For example:

```ruby
Circuitry.config do |config|
  config.publisher_middleware.add Circuitry::Middleware::Seismograph, namespace: 'messages', stat: 'pub'
  config.subscriber_middleware.add Circuitry::Middleware::Seismograph, namespace: 'messages', stat: 'sub'
end
```

Similarly, you can remove the middleware from either one of these via the `#remove` method per the
[circuitry documentation](https://github.com/kapost/circuitry#middleware).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run
the tests. You can also run `bin/console` for an interactive prompt that will allow you to
experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new
version, update the version number in `version.rb`, and then run `bundle exec rake release`, which
will create a git tag for the version, push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kapost/circuitry-seismograph.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
