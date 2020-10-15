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

### In Docker

1. Uncomment `gem 'contrast-agent' in the Gemfile`.

2. Move a `contrast-security.yaml` file to the root directory. In that configuration, ensure that 
   1. the `api` section is populated with valid connection settings
   2. `api.request_audit.enable` is set to `true`.
   3. `assess.enable` is set to `true`.
   4. `assess.sampling.enable` is set to `false`.

3. Place an agent, named `contrast-agent.gem` in the `agent` directory.

4. Run `docker-compose up --abort-on-container-exit`.
   * add `--build` if iterating on containers

### To run manually

To run the integration tests locally there are a few steps: 

1. Reset the testing state.
   1. reset the application in TeamServer
   2. empty the `./rundata-localhost` directory

2. Uncomment `gem 'contrast-agent'` in the `Gemfile`.

3. Install dependencies by running `CI_TEST=true bundle install`.

4. Install required programs by running:
   1. If on Mac install `xquartz` (`brew cask install xquartz`).
   2. If on Ubuntu install `xvfb` (`apt-get install xvfb`).

5. cd to `./spec/dummy`

6. Create a `contrast_security.yaml` with proper connection settings and:
    1. `api.request_audit.enable` set to `true`
    2. `api.request_audit.requests` set to `true`
    3. `api.request_audit.path` set to `./run-data/localhost/messages`
    4. `assess.enable` set to `true`
    5. `assess.sampling.enable` set to `false`
    6. `protect.enable` set to `true`

7. Run the application: `CI_TEST=true bundle exec rails s`.

8. cd to the git root directory.

9. Run the test script: `TEST_HOSTS=localhost:3000 bundle exec ruby spec/integration/runner.rb`.

NOTE: If you run into a "Display socket is taken but lock file is missing" exception you can resolve this with:
`mkdir /tmp/.X11-unix && sudo chmod 1777 /tmp/.X11-unix && sudo chown root /tmp/.X11-unix/`