class BookDecorator < Draper::Decorator

  decorates_association :authors

  delegate_all

  DEFAULT_IMAGE = 'book-cover.png'

  def authors_names
    authors.map(&:full_name).join(', ')
  end

  def dimensions
    ["H: #{height} \"", "W: #{width}\"", "D: #{depth}\""].join(' x ')
  end

  def admin_image
    return  h.image_tag(DEFAULT_IMAGE,class: 'admin-cover-book') unless images_exists?
    h.image_tag(book_images.first.image.admin_img.url)
  end

  def medium_image
    images_exists? ? book_images.first.image.medium_img.url : DEFAULT_IMAGE
  end

  def main_avatar
    images_exists? ? book_images.first.image.large_img.url : DEFAULT_IMAGE
  end

  def images_exists?
    book_images.any?
  end

end
