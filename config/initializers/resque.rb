Resque.configure do |config|
  if ENV["REDISTOGO_URL"]
    config.redis = ENV["REDISTOGO_URL"]
  end
end
