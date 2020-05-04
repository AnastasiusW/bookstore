class BookImage < ApplicationRecord
  belongs_to :book, optional: true

  mount_uploader :image, ImageUploader
end
