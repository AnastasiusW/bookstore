require 'rails_helper'

RSpec.describe 'Books', type: :feature, js: true do
  let(:book) { create(:book, description: FFaker::Book.description(rand(4..10))) }

  before  do
    @book_page = BookPrism.new
  end

  context 'with description' do
    it 'show full description' do
      visit(book_path(book))
      click_link(I18n.t('book.read_more'))
      expect(page).to have_content(book.description)
    end
  end

  context 'with price calculator' do
    it 'show case when increment count book' do
      visit(book_path(book))
      @book_page.plus.click
      expect(@book_page.id_quantity.value).to eq("2")

    end
  end
end
