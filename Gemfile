# Edit this Gemfile to bundle your application's dependencies.
source 'http://rubygems.org'


# git "git://github.com/rails/rack.git"
# git "git://github.com/rails/rails.git"
# gem "rails", :git => "http://github.com/rails/rails.git"


# path "vendor/rails", :glob => "{*/,}*.gemspec"
gem 'rails', '3.2.3'

gem "config_fu"
gem 'paperclip'
gem 'authlogic'
gem 'jquery-rails'
gem "dynamic_form"

## Bundle edge rails:
# gem "rails", :git => "git://github.com/rails/rails.git"

# source :gemcutter
gem 'twitter'
# git "git://github.com/thoughtbot/paperclip.git", :branch => "rails3"



# source 'http://gems.github.com'


group :production do
  gem 'pg'
  gem 'thin'
end

## Bundle gems used only in certain environments:
# gem "rspec", :group => :test
group :test, :development do
  gem "mocha"
  gem "mysql2"
end
