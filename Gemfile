source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.8'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Use SCSS for stylesheets
gem 'sassc-rails', '~> 1.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

gem 'puma', '~> 3.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Savvspace additions:
gem 'haml-rails'
gem 'rdiscount'
gem 'devise'
gem 'bootstrap-sass', '~> 3.3'
gem 'simple_form'
gem 'cloudinary'
gem 'attachinary'
gem 'bootstrap-wysihtml5-rails', github: 'nerian/bootstrap-wysihtml5-rails'
gem 'rollbar'
gem 'pundit', '~> 1.1'
gem 'gibbon'
gem 'delayed_job_active_record'
gem 'twilio-ruby', '~> 4.11.1'
gem 'rack-tracker'
gem 'ransack'
gem 'inky-rb', require: 'inky'
gem 'premailer-rails'
gem 'newrelic_rpm'
gem 'jquery-ui-rails'
gem 'mandrill-api'
gem 'stripe-rails'
gem 'bootstrap-multiselect-rails'
gem 'jquery-turbolinks'

# RETS Rabbit dependencies
gem 'httparty'

# Caching
gem 'dalli'
gem 'rack-cache'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'dotenv-rails', groups: [:development, :test]
gem "rubocop", require: false
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails', '~> 3.5'
  gem 'simplecov', :require => false
  gem 'factory_girl_rails'
  gem 'shoulda-matchers', '~> 3.0'
  gem 'cucumber-rails', :require => false
  gem 'syntax'
  gem 'database_cleaner'
  gem 'fakeweb'
  gem 'pundit-matchers', '~> 1.1.0'
  gem 'rails_real_favicon'
  gem 'pry'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'meta_request'
  gem 'spring'
end

group :production do
  gem 'rails_12factor'
end
