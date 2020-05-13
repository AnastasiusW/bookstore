CarrierWave.configure do |config|
  if Rails.env.production?
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
  else
    config.storage = :file
    if Rails.env.test?
      Dir["#{Rails.root}/app/uploaders/*.rb"].sort.each { |file| require file }
      if defined?(CarrierWave)
        CarrierWave::Uploader::Base.descendants.each do |klass|
          next if klass.anonymous?

          klass.class_eval do
            def cache_dir
              'test/uploads/cache'
            end

            def store_dir
              "test/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
            end
          end
        end
      end
    end
  end
end
