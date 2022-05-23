#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bundle exec rails s -b 0.0.0.0

# if [ -z "$RAILS_ENV" ]; then
#   echo "RAILS_ENV variable is not set, will use development by default"
#   # bundle exec rails db:reset
#   # bundle exec rails db:migrate
#   bundle exec rspec
# else
#   bundle exec rails s -e $RAILS_ENV -p 3000 -b 0.0.0.0
# fi