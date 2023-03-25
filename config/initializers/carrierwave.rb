require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.asset_host = ENV['BACKEND_ORIGIN']
  config.storage = :file
  config.cache_storage = :file
end