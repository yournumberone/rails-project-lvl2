install:
	bundle install
	bin/rails db:migrate
	bundle exec rake db:seed
lint:
	bundle exec rubocop
	slim-lint app/views
test:
	rake test

.PHONY: test