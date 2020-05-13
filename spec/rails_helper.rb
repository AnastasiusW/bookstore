# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
  minimum_coverage 95
end

require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
require 'capybara/rails'

require 'capybara/rspec'
require 'selenium-webdriver'
require 'site_prism'
require 'site_prism/all_there'
require 'pundit/matchers'

abort('The Rails environment is running in production mode!') if Rails.env.production?
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }
Dir[Rails.root.join('spec', 'features', 'support', '**', '*.rb')].sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.after(:all) do
    FileUtils.rm_rf(Dir["#{Rails.root}/public/test"])
  end
end
