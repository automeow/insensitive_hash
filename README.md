# InsensitiveHash

InsensitiveHash is a hash where the keys :foo, 'foo', :FOO and 'FOO' are equal

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'insensitive_hash'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install insensitive_hash

## Usage

```ruby
hash = InsensitiveHash.new(foo: { bar: 42 })
hash['foo']['BAR'] # 42

hash['foo'].merge!('Bar' => 79)
hash[:Foo][:baR] # 79
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/automeow/insensitive_hash.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

