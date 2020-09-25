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

2.) Run `bundle install`.

3.) Run `cd /spec/dummy`.

4.) Run `bundle exec rails s`.

5.) Visit: `http://localhost:3000/vulneruby_engine/` and you will be at the engine's home page.

# Integration Tests

1.) Uncomment `gem 'contrast-agent' in the Gemfile`.

2.) Move a `contrast-security.yaml` file to the `spec/dummy` directory, ensure that `assess.enable` is set to `true`.


### In Docker

1.) Place an agent, named `contrast-agent.gem` in the `agent` directory.

2.) Run `docker-compose up --abort-on-container-exit`.

### To run manually

To run the integration tests locally there are a few steps: 

1.) Run `CI_TEST=true bundle install`.

2a.) If on Mac install `xquartz` (`brew cask install xquartz`).
2b.) If on Ubuntu install `xvfb` (`apt-get install xvfb`).

3.) cd to `./spec/dummy`

4.) Create a `contrast_security.yaml` with proper connection settings and:
    1.) `assess.enable` set to `true`
    2.) `api.request_audit.enable` set to `true`
    3.) `api.request_audit.requests` set to `true`
    4.) `api.request_audit.path` set to `./run-data/localhost/messages`
  
5.) Run the application: `CI_TEST=true bundle exec rails s`.

6.) If using an existing application, be sure to reset it.

7.) Run the test script: `TEST_HOSTS=localhost:3000 bundle exec ruby spec/integration/runner.rb`.

NOTE: If you run into a "Display socket is taken but lock file is missing" exception you can resolve this with:
`mkdir /tmp/.X11-unix && sudo chmod 1777 /tmp/.X11-unix && sudo chown root /tmp/.X11-unix/`