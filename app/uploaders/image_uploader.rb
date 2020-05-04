class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :admin_img do
    process resize_to_fit: [50, 50]
  end

  version :large_img do
    process resize_to_fit: [550, nil]
  end

  version :medium_img do
    process resize_to_fit: [300, nil]
  end

  version :small_img do
    process resize_to_fit: [150, nil]
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
