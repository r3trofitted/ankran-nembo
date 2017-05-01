source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'jbuilder', '~> 2.5'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.0'
gem 'sass-rails', '~> 5.0'
gem 'sqlite3'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'uglifier', '>= 1.3.0'

# gem 'bcrypt', '~> 3.1.7'
# gem 'capistrano-rails', group: :development
# gem 'redis', '~> 3.0'
# gem 'therubyracer', platforms: :ruby

group :development, :test do
  gem 'capybara', '~> 2.7.0'
  gem 'rubocop', require: false
  gem 'selenium-webdriver'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', github: 'rails/web-console'
end

group :test do
  gem "codeclimate-test-reporter", require: false
  gem "simplecov", '>= 0.13.0', require: false
end
