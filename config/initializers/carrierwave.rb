CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.credentials.config[:aws][:access_key_id],
    aws_secret_access_key: Rails.application.credentials.config[:aws][:secret_access_key],
    region: Rails.application.credentials.config[:aws][:region]
  }
  config.storage = :fog
  config.fog_directory = Rails.application.credentials.config[:aws][:s3_bucket_name]
  config.fog_public = false
end
