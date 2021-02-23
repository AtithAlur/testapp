#!/bin/bash

# Install dependencies
bundle install

# Create DB tables
rails db:migrate

# Run tests
RAILS_ENV=test rails db:drop db:create db:migrate
RAILS_ENV=test rspec

# Creates Magic Potion product
rails db:seed

# Runs rails server
rails s -b 0.0.0.0
