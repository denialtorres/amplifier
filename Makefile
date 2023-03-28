NAME=dev
SRC=github.com
TAG=dev-lms-poc

.DEFAULT_GOAL := help
.PHONY: help

help:
	@grep -E '^[a-zA-Z_-_/]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

app/init: ## Prepare your local dev environment
	cp .env.sample .env

docker/build: ## Build the docker image
	docker build \
		-f dockerfile/Dockerfile \
		--tag=$(TAG) \
		--no-cache \
		--build-arg BUNDLE_GITHUB__COM \
		--build-arg GITHUB_ACCESS_TOKEN .

docker/rm: ## Deletes the docker image
	docker image rm $(TAG)

docker/up: ## Start Docker containers
	docker-compose up $(NAME)

docker/down: ## Stop Docker containers
	docker-compose down

docker/bash: ## Provide bash access on Rails container
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev zsh

# Rails commands
rails/bundle: ## Install gems
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle install

rails/bounce: ## Initialize Rails Gems and Database
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle install
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle exec rake db:drop
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle exec rake db:create
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle exec rake db:migrate
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle exec rails db:drop RAILS_ENV=test
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle exec rails db:create RAILS_ENV=test
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle exec rails db:migrate RAILS_ENV=test

rails/start-db: ## Create and migrate database
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle exec rake db:create
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle exec rake db:migrate
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle exec rails db:create RAILS_ENV=test
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle exec rails db:migrate RAILS_ENV=test

rails/db/migrate: ## Migrate DB
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle exec rake db:migrate
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle exec rails db:migrate RAILS_ENV=test

rails/db/migrate/status: ## Migrate DB Status
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle exec rake db:migrate:status
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle exec rails db:migrate:status RAILS_ENV=test

rails/server: ## Starts Rails server on port 3000
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle exec rails s -b 0.0.0.0

rails/console: ## Starts Rails console
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle exec rails console

rspec: ## Run RSpec from specific domain argument example: make rspec DOMAIN=foo FILE=path_file
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle exec rspec domains/$(DOMAIN)/spec/$(FILE)

linter/rubocop: ## Run rubocop
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle exec rubocop

linter/rubocop/fix: ## Run rubocop
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev bundle exec rubocop -A
