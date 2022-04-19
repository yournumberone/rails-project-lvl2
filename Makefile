install:
	bundle install
	bundle exec rake db:seed
lint:
	rubocop
	slim-lint app/views
test:
	rake test

.PHONY: test