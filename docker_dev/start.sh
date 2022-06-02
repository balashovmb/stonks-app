#!/bin/bash

if ! gem list foreman -i; then
  echo "Installing foreman for the first time...";
  gem install foreman
fi

echo "Bundling gems..."
bundle install --jobs 4

echo "Clearing logs..."
rm -f log/*.log

echo "Removing old pids..."
rm -f tmp/pids/server.pid

echo "Removing old cache..."
rm -rf tmp/cache

echo "Yarn install..."
yarn --network-timeout 10000

echo "Starting the foreman..."

foreman start -f Procfile.docker_dev -p 3000
# Use just rails
#echo "Starting the rails..."
#bundle exec rails s -b '0.0.0.0'
