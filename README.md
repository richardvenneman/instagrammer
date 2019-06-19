# Instagrammer

Instagrammer lets you fetch Instagram user info and posts. This is done by crawling the Instagram web interface, powered by [Capybara](https://github.com/teamcapybara/capybara/) and a headless Chrome Selenium driver.

[![Build Status](https://travis-ci.org/richardvenneman/instagrammer.svg?branch=master)](https://travis-ci.org/richardvenneman/instagrammer)
[![Gem Version](https://badge.fury.io/rb/instagrammer.svg)](https://badge.fury.io/rb/instagrammer)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'instagrammer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install instagrammer

## Usage

### User

Accessing certain properties on an account that is private will result in a `PrivateAccount` exception. In some cases Instagram doesn't expose any meta data through. In these cases a `UserInvalid` exception will be raised when accessing certain properties.

Therefor you can check if the account is scrapable with the `#valid?` instance method.

#### Metadata

The meta counts data is available for both public as well as private accounts:

```ruby
user = Instagrammer::User.new("richardvenneman")
user.follower_count # => "204"
user.following_count # => "141"
user.post_count # => "91"
```

#### Bio

Bio info is currently available for public accounts only:

```ruby
user = Instagrammer::User.new("richardvenneman")
user.name # => "Richard Venneman"
user.username # => "@richardvenneman"
user.avatar # => "https://www.instagram.com/static/images/ico/favicon-200.png/ab6eff..."
user.bio # => "👨🏻‍💻 Partner at GoNomadic B.V.\nTraveling and building 🏙 @cityspotters"
user.url # => "https://www.cityspotters.com/"
```

## Motivation

The problem with scrapers is that they always brake. Especially Instagram/Facebook seems to put in a lot of effort into this. This gem tries to approach that challenge a bit different than other Ruby Instagram scrapers. Decent test coverage should test the integration continuously and good code quality should allow for quick and easy updates may any changes in the Instagram web interface happen.

The main focus is currently retrieving user posts with some metadata while maintaining a stable implementation. Therefor I try to avoid naive page selectors and rely on meta data where possible.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/richardvenneman/instagrammer.
