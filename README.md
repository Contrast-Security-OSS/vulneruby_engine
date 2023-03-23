# VulnerubyEngine
This Ruby on Rails engine exposes an API that makes use a vulnerable methods and functions when passed user data.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'vulneruby_engine', git: 'https://github.com/Contrast-Security-OSS/vulneruby_engine'
```

And then execute:
```bash
$ bundle
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

## Adding to the Integration Tests

Before runnig the `Vulenruby Script` for building images, you might need different configuration. 
`./scripts/config.json` is the configuration file used by `push_github_images` script.

The configuration file looks like this:

```
{
  "dockerfile_base": "./docker/Dockerfile_base",
  "target": "ghcr.io/contrast-security-oss/vulneruby_engine/base",
  "ruby_versions": [ 
    3.0,
    3.1,
    3.2 
  ],
  "distros": [
    "-slim-bullseye",
    "-slim-buster",
    "-alpine3.16"
  ]
}
```

The script can be run with minimum 1 `Ruby version` and 1 `Distro` set. There is validation to check
presence of reqiured to access `Docker` ENV variable: `CR_PAT` and `GH_USERNAME`.

Before run you need to: 

1. Create your PAT at Github:
   you need to first create a [Personal Access Token](https://docs.github.com/en/github/authenticating-to-$
   for yourself -- be sure to save it as you can only ever see it the first time you create it. This PAT needs to have$
   enabled (obnoxiously, that means the action will read as "Disable SSO") as well as the permissions `repo`,
  `write:packages`, and `delete:packages` (to replace an existing package with the new ones you're creating).
2. Set your PAT `export CR_PAT=#{MY_PAT}`
3. Set you GitHub's username: `export GH_USERNAME=my_email_address`

## Docker images build

The Ruby Agent uses prebuild docker images to run it's e2e tests. You can build and push images locally.

If you'd like to add a new test to this suite, you'll need to do a few things to update our testing pipeline
accordingly. We use GitHub packages in our testing pipeline to save time and money when pulling the base
vulneruby_engine docker image. As such, if you change the code in the vulneruby_engine project, you need t$
[Vulneruby Packages](https://github.com/Contrast-Security-OSS/vulneruby_engine/pkgs/container/vulneruby_en$
for the pipeline to use.

Steps: 
- Checkout `VulnerubyEngine` project.
- execute `push_github_images` script.

```shell
$ chmod 755 scripts/push_github_images.sh
$ ./scripts/push_github_images.sh
```
The script is designed to build all images and push them.

If done correctly, you should see all new tags with `0` downloads in the [Package Registry](https://github.com/Contrast-Security-OSS/vulneruby_engine/pkgs/container/vulneruby_engine%2Fbase).
