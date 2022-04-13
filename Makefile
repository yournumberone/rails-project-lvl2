install:
	bundle install
lint:
	rubocop
	slim-lint app/views
test:
	rake test

.PHONY: test