#!/bin/sh

rm /app/tmp/pids/server.pid

yarn install --check-files
bundle exec rake db:create db:migrate db:seed
bundle exec rails server -b 0.0.0.0
