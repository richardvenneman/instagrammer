# Instagrammer

Instagrammer lets you fetch Instagram user info and posts. This is done by crawling the Instagram web interface, powered by [Capybara](https://github.com/teamcapybara/capybara/) and a headless Chrome Selenium driver. Read more about the [motivation to build this gem](#motivation)

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

Create a new user with `Instagrammer::User.new("username")` or simply `Instagrammer.new("username")`.

Accessing certain properties on an account that is private will result in a `PrivateAccount` exception. In some cases Instagram doesn't expose any meta data through. In these cases a `UserInvalid` exception will be raised when accessing certain properties.

Therefor you can check if the account is scrapable with the `#public?` instance method.

#### Metadata

The meta counts data is available for both public as well as private accounts:

```ruby
user = Instagrammer.new("richardvenneman")
user.follower_count # => "204"
user.following_count # => "141"
user.post_count # => "91"
```

#### Bio

Bio info is currently available for public accounts only:

```ruby
user = Instagrammer.new("richardvenneman")
user.name # => "Richard Venneman"
user.username # => "@richardvenneman"
user.avatar # => "https://www.instagram.com/static/images/ico/favicon-200.png/ab6eff..."
user.bio # => "👨🏻‍💻 Partner at GoNomadic B.V.\nTraveling and building 🏙 @cityspotters"
user.url # => "https://www.cityspotters.com/"
```

#### Posts

Get the posts for a specific user by using the `#get_posts(_limit_)` user method.

```ruby
user = Instagrammer.new("richardvenneman")
user.get_posts(3) # => [#<Instagrammer::Post:70223732051200..>, #<Instagrammer::Post:70223732051200..>, #<Instagrammer::Post:70223732051200..>]
```

See below for the available post methods

### Post

Create a new post with `Instagrammer::Post.new("shortcode")`.

```ruby
post = Instagrammer::Post.new("Bg3VjfwDRDw")
post.photo? # => true
post.caption # => "🌋 Mount Agung as seen from 🌋 Mount Batur just after sunrise 🌅"
post.upload_date # => #<DateTime: 2018-03-28T11:07:26+00:00 ((2458206j,40046s,0n),+0s,2299161j)
post.comment_count # => 3
post.like_count # => 52
post.image_url # => "https://instagram.foem1-1.fna.fbcdn.net/vp/04bffab7e91872110690173cbac1ba28/5D9FDCD0/t51.2885-15/e35/29416707_933709783459981_1377808440356765696_n.jpg?_nc_ht=instagram.foem1-1.fna.fbcdn.net"
post.image_urls # => [{:url=>"https://instagram.foem1-1.fna.fbcdn.net/vp/b962b338f5024309e3242ec3e4158681/5DA27835/t51.2885-15/sh0.08/e35/s640x640/29416707_933709783459981_1377808440356765696_n.jpg?_nc_ht=instagram.foem1-1.fna.fbcdn.net", :width=>640}, {:url=>",https://instagram.foem1-1.fna.fbcdn.net/vp/fb1477d8dc17c9d1a6b36c8107b4a5b2/5DC4FA35/t51.2885-15/sh0.08/e35/s750x750/29416707_933709783459981_1377808440356765696_n.jpg?_nc_ht=instagram.foem1-1.fna.fbcdn.net", :width=>750}, {:url=>",https://instagram.foem1-1.fna.fbcdn.net/vp/04bffab7e91872110690173cbac1ba28/5D9FDCD0/t51.2885-15/e35/29416707_933709783459981_1377808440356765696_n.jpg?_nc_ht=instagram.foem1-1.fna.fbcdn.net", :width=>1080}]
```

Additionally video posts are somewhat supported as well. Image URLs and like counts are not available for videos.

```ruby
post = Instagrammer::Post.new("Byx0Nd3A3qr")
post.video? # => true
post.watch_count # => 8035142
```

## Motivation

The problem with scrapers is that they always brake. Especially Instagram/Facebook seems to put in a lot of effort into this. This gem tries to approach that challenge a bit different than other Ruby Instagram scrapers. Decent test coverage should test the integration continuously and good code quality should allow for quick and easy updates may any changes in the Instagram web interface happen.

The main focus is currently retrieving user posts with some metadata while maintaining a stable implementation. Therefor I try to avoid naive page selectors and rely on meta data where possible.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/richardvenneman/instagrammer.
