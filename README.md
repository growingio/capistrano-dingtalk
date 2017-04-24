# Capistrano::Dingtalk

This gem works with Capistrano v3.0.0 and above and was based off the work on [this gem](https://github.com/scottsuch/capistrano-graphite).

Adding this gem to [Capistrano](https://github.com/capistrano/capistrano) extends functionality by pushing notice to dingtalk upon deployment and rollback.

## Installation

Install it manually:

    $ gem install capistrano-dingtalk

Otherwise, add this line to your application's Gemfile:

    gem 'capistrano-dingtalk'

And then execute:

    $ bundle

## Usage

### Setup your application

Add the following line to your `Capfile`.

    require "capistrano/dingtalk"

### Configurable options

The access token of dingtalk robot.

    set :dingtalk_access_token, "xxxxxxxx"

Disable sending notices for a particular stage by setting the following:

    set :suppress_dingtalk_notice, "true"      # This is set to false by default

### Test that it's working

You can run the following on it's own assuming you have configured the dingtalk access token.

    $ bundle exec cap <stage> deploy:post_dingtalk['deploy']

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
