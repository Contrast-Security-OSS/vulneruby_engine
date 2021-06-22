
APP_ROOT=$(abspath $(dir $(lastword $(MAKEFILE_LIST))))
export CI_TEST=true

# If ruby version is not correct, set to rbenv's 2.7.x.
# If rbenv is not available, ruby --version should work regardless of .ruby-version.
.PHONY: ruby_ver
ruby_ver:
	ruby --version > /dev/null ||  rbenv versions --bare | grep 2.7 > .ruby-version || \
		echo "No appropriate ruby version available"
	@echo ".ruby-version set to:" `cat .ruby-version`

.PHONY: vendor
vendor: ruby_ver
	bundle install

.PHONY: dirs
dirs:
	mkdir -p $(APP_ROOT)/log $(APP_ROOT)/spec/dummy/log

.PHONY: db
db: vendor dirs
	bundle exec rails db:setup

run: vendor dirs db
	bundle exec rails server
