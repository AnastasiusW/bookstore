require 'rails_helper'

RSpec.describe 'Books', type: :feature, js: true do
  let(:book) { create(:book, description: 'world' * Book::DESCRIPTION_LIMIT) }

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
      find('i.fa.fa-plus').click
      expect(page.find_by_id('quantity_input').value).to eq('2')
    end
  end
end
