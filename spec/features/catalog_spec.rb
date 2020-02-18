require 'rails_helper'

RSpec.feature "Catalogs", type: :feature, js: true do
  before do
    create_list(:category, 4)
  end
  context 'with categories' do
    let(:book) { create(:book, category_id: Category.all.sample.id) }


    it 'shows books only from choosen category' do
      visit(books_path)
      find('.filter-link', text: book.category.title, match: :first).click
      expect(page).to have_content(book.title)

    end
  end

end
