# VulnerubyEngine
This Ruby on Rails engine exposes an API that makes use a vulnerable methods and functions when passed user data.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'vulneruby_engine'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install vulneruby_engine
```

Edit your `routes.rb` to mount the engine. 
```ruby
Rails.application.routes.draw do
  mount VulnerubyEngine::Engine => "/vulneruby_engine"
end
```

## Development

1.) Clone this repo.

2.) Run `CI_TEST=true bundle update`.

3.) Run `CI_TEST=true bundle exec rake db:setup`.

4.) Run `CI_TEST=true bundle exec rails s`.

5.) Visit: `http://localhost:3000/vulneruby_engine/` and you will be at the engine's home page.
