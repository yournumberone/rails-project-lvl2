install:
	bundle install
	bin/rails db:migrate
	bundle exec rake db:seed
lint:
	bundle exec rubocop
	bundle exec slim-lint app/views
test:
	bundle exec rake test

.PHONY: test