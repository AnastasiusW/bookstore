RSpec.describe 'Homes', type: :feature do
  let(:count_book) { Book::LATEST_BOOK_COUNT }

  before do
    create_list(:book, 5)
    visit(root_path)
  end

  context 'when get started click button' do
    it 'open catalog when click get started' do
      click_link(I18n.t('home.get_started'))
      expect(page).to have_current_path(books_path)
    end
  end

  it 'have latest books' do
    within '#slider' do
      expect(page).to have_selector('.item',visible:false, count: count_book)
    end
  end
end
