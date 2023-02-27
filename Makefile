install:
	bundle install

build:
	rake assets:precompile

lint:
	bundle exec rubocop ./app
	bundle exec slim-lint ./app/views/

test:
	rake test

start-rake:
	bundle exec rake

.PHONY: test