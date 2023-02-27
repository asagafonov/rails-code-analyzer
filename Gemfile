# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'enumerize'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'octokit'
gem 'omniauth-github'
gem 'omniauth-rails_csrf_protection'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4', '>= 7.0.4.2'
gem 'rails-i18n'
gem 'simple_form'
gem 'slim'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv'
  gem 'faker'
end

group :development do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'html2slim'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'slim_lint'
  gem 'sqlite3', '~> 1.4'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'minitest-power_assert'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :production do
  gem 'pg'
end
