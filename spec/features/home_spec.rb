require 'rails_helper'

RSpec.describe 'Homes', type: :feature do
  let (:count_book) {Book::LATEST_BOOK_COUNT}

  before do
    create_list(:book, 5)
    visit(root_path)
    @home_page = HomePrism.new
  end


  context 'get started click button' do
    it 'open catalog when click get started' do
      click_link(I18n.t('home.get_started'))
      expect(page).to have_current_path(books_path)
    end
  end


end
