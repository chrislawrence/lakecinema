require 'webmock'
require 'fake_mailchimp'
include WebMock::API

Lakecinema::Application.configure do
  config.asset_host = 'http://lakecinema.dev'
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true

  stub_request(:any, /us2.api.mailchimp.com/).to_rack(FakeMailchimp)
end
