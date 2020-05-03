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

  return  h.image_tag(DEFAULT_IMAGE,class: 'admin-cover-book') if exist_images?
  h.image_tag(book_images.first.image.admin_img.url)

  end

  def exist_images?
    book_images.empty?
  end
end
