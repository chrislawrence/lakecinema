ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/email/rspec'
# require 'rspec/autorun'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

Capybara.javascript_driver = :webkit

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.before(:each) do
    stub_request(:any, /api.themoviedb.org/).to_rack(FakeTmdb)
    stub_request(:any, /us2.api.mailchimp.com/).to_rack(FakeMailchimp)
  end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.include Features, :type => :feature

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
