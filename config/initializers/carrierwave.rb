CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.config[:aws][:key],
      aws_secret_access_key: Rails.application.credentials.config[:aws][:secret_key],
      region: Rails.application.credentials.config[:aws][:region]
    }
    config.storage = :fog
    config.fog_directory = Rails.application.credentials.config[:aws][:bucket]
  else
    config.storage = :file
  end
end
