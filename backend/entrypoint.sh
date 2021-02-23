#!/bin/bash

# Install dependencies
bundle install

# Create DB tables
rails db:migrate

# Run tests
rspec

# Creates Magic Potion product
rails db:seed

# Runs rails server
rails s -b 0.0.0.0
