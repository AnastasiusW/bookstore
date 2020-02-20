class BookDecorator < Draper::Decorator
  decorates_association :authors

  def self.collection_decorator_class
    PaginatingDecorator
  end

  delegate_all

  def authors_names
    authors.map(&:full_name).join(', ')
  end

  def dimensions
    ["H: #{height} \"", "W: #{width}\"", "D: #{depth}\""].join(' x ')
  end

end
