install:
	bundle install
	rake db:seed
lint:
	bundle exec rubocop
	bundle exec slim-lint app/views
test:
	rake test

.PHONY: test