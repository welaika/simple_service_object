# SimpleServiceObject

A simple command pattern implementation in Ruby.

[![Build Status](https://travis-ci.org/welaika/simple_service_object.svg?branch=master)](https://travis-ci.org/welaika/simple_service_object)
[![Code Climate](https://codeclimate.com/github/welaika/simple_service_object/badges/gpa.svg)](https://codeclimate.com/github/welaika/simple_service_object)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_service_object'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_service_object

## Usage

### Basic usage

Write your service object class, which must inherit from `SimpleServiceObject::Base` and must define
a `call` instance method.

```ruby
  class SubscribeUser < SimpleServiceObject::Base
    def initialize(user)
      @user = user
    end

    def call
      add_user_to_newsletter_recipients(@user)
      notify_user(@user)
    end

    private

    def add_user_to_newsletter_recipients(user)
      # ...
    end

    def notify_user(user)
      # ...
    end
  end
```

To run your command, simply:

```ruby
  SubscribeUser.call(my_new_user) # arguments are passed to your class '#initialize' method
```

### Return value and errors

You can add errors using the `errors` method, which exposes to you an array of errors.

```ruby
class CalculateSquareRoot < SimpleServiceObject::Base
  def initialize(number)
    @number = number
  end

  def call
    if number < 0
      errors.push("Cannot calculate square root!")
      return
    end
    Math.sqrt(@number)
  end
end
```

```ruby
  result = CalculateSquareRoot.call(9)
  result.success? # true
  result.failure? # false
  result.errors # []
  result.value # 3.0
```

```ruby
  result = CalculateSquareRoot.call(-1)
  result.success? # false
  result.failure? # true
  result.errors # ["Cannot calculate square root!"]
  result.value # nil
```

You can also use `.call!` instead of `.call`. If there aren't any errors, it will return the value,
otherwise it will raise an exception.

```ruby
  CalculateSquareRoot.call!(9) # 3.0
  CalculateSquareRoot.call!(-1) # raises SimpleServiceObject::FailureError
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run rubocop and tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/welaika/simple_service_object. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
