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

  context 'with view more button', skip_before: true do
    it 'shows more books' do
      create_list(:book, 2)
      stub_const('Book::BOOKS_PER_PAGE', 1)
      visit(books_path)
      expect { click_link(I18n.t('shop.view_more')); sleep(1) }.to change { all('.title').count }.by(1)

    end

    it 'hides button when all books are shown' do
      create_list(:book, 2)
      stub_const('Book::BOOKS_PER_PAGE', 1)
      visit(books_path)

      expect(page).to have_content(I18n.t('shop.view_more'))
      click_link(I18n.t('shop.view_more'))
      expect(page).not_to have_content(I18n.t('shop.view_more'))
    end

  end

  context 'when click on eye icon' do
    it 'render book info page' do
      create(:book)
      visit(books_path)

      link = find('a.thumb-hover-link', match: :first)['href']
      find('.fa-eye', match: :first).click()
      expect(page).to have_current_path(link)
    end
  end
end
