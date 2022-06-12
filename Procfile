release: bundle exec rails db:migrate
# js: yarn build
# css: yarn build:css
web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -c 2
