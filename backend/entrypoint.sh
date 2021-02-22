#!/bin/bash

bundle install
rails db:migrate
rails db:seed

tail -f /dev/null
