[![Build Status](https://travis-ci.org/bolshakov/sidekiq-global_id.svg?branch=master)](https://travis-ci.org/bolshakov/sidekiq-global_id)

# Sidekiq::GlobalId

This gem provides Sidekiq middleware to serialize ActiveRecord objects with GlobalId. Actually it uses the same mechanism as
 ActiveJob uses internally to serialize job arguments, and works not only with ActiveRecord objects, but also with Hashes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq-global_id'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sidekiq-global_id

## Usage

Configure Sidekiq to use server and client middleware:


```ruby
Sidekiq.server_middleware do |chain|
  chain.prepend Sidekiq::GlobalId::ServerMiddleware
end

Sidekiq.client_middleware do |chain|
  chain.prepend Sidekiq::GlobalId::ClientMiddleware
end
```

Now you can pass ActiveRecord arguments into Sidekiq worker:

```ruby
user = User.create!(params)

WelcomeEmailSender.perform_async(user)
```

## Testing

If you're using [rspec-sidekiq](https://github.com/philostler/rspec-sidekiq) gem, `require 'sidekiq/global_id/rspec'` to deserialize global ids:

```ruby
require 'sidekiq/global_id/rspec'

it 'sends welcome email to user' do
  WelcomeEmailSender.perform_async(user)
  expect(WelcomeEmailSender).to have_enqueued_job(user)
end
```

In the event you are testing Sidekiq workers _inline_ using Sidekiq's [suggested approach](https://github.com/mperham/sidekiq/wiki/Testing#setup). To allow test inline workers to deserialize the GlobalId `Sidekiq::GlobalId::ServerMiddleware` must also be included in the [Sidekiq Test Harness](https://github.com/mperham/sidekiq/wiki/Testing#testing-server-middleware).

```ruby
require "sidekiq/testing"
Sidekiq::Testing.inline!
Sidekiq::Testing.server_middleware do |chain|
  chain.prepend Sidekiq::GlobalId::ServerMiddleware
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bolshakov/sidekiq-global_id.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

