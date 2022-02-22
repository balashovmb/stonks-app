source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise'
gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
gem 'sass-rails', '>= 6'
gem 'sidekiq'
gem 'slim-rails'
gem 'stimulus_reflex', '~> 3.4'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'unicorn'
gem 'webpacker', '~> 5.0'
gem 'whenever', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'bullet'
  gem 'capistrano', require: false
  gem 'capistrano3-unicorn', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-sidekiq', require: false
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'action-cable-testing'
  gem 'capybara', '>= 3.26'
  gem 'launchy'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'timecop'
  gem 'webdrivers'
  gem 'webmock'
end
