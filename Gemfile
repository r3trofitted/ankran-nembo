source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 3.0"

gem 'jbuilder', '~> 2.5'
gem 'puma', '~> 5.6'
gem 'rails', '~> 6.0.0'
gem 'sass-rails', '~> 6.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'uglifier', '>= 1.3.0'
gem 'bootsnap', '>= 1.1.0', require: false

# gem 'bcrypt', '~> 3.1.7'
# gem 'capistrano-rails', group: :development
# gem 'redis', '~> 3.0'
# gem 'therubyracer', platforms: :ruby

group :development, :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', github: 'rails/web-console'
end

group :test do
  gem "simplecov", '>= 0.13.0', require: false
end
