install:
	bundle install

build:
	rake assets:precompile

lint:
	bundle exec rubocop ./app
	bundle exec slim-lint ./app/views/

test:
	bundle exec rake

prepare-test-env:
	rake db:test:prepare

.PHONY: test