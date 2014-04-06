source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'
gem 'pg'

# Use SCSS for stylesheets
gem 'therubyracer', platforms: :ruby # or any other runtime
gem 'less-rails'
gem 'autoprefixer-rails'
gem 'semantic-ui-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'execjs'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

gem 'rails-i18n', '~> 4.0.2'

# Auth
gem 'devise'
gem 'devise-i18n-views'
gem "cancancan", "~> 1.7.0"

# Pagination - https://github.com/mislav/will_paginate/
gem 'will_paginate', '~> 3.0'
# Use unicorn as the app server
# gem 'unicorn'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'rails_12factor', group: :production

group :development do
	# Better debud
	gem 'better_errors'
  	gem 'binding_of_caller'
  	gem 'meta_request'

	# Use Capistrano for deployment
	gem 'capistrano'
	gem 'rspec-rails', "~> 2.12"
	gem 'shoulda-matchers'
	gem "capybara", "~> 2.0"
	gem "cucumber", "~> 1.3"
	gem "cucumber-rails", "~> 1.4.0", require: false
	gem 'database_cleaner'
end


group :test, :development do
	gem 'debugger'
	gem "spork-rails", "~> 4.0.0"

	gem "guard-rails", "~> 0.5.0"
	gem "guard-rspec", "~> 4.2.8"
	gem "guard-cucumber", "~> 1.4.1"
	gem "guard-spork", "~> 1.5.1"
	gem "guard-livereload", "~> 2.1.1"
	gem "guard-bundler", "~> 2.0.0"
end
