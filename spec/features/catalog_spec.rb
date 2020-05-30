RSpec.describe 'Catalogs', type: :feature, js: true do
  let(:catalog_page) { CatalogPage.new }

  context 'with categories filter' do
    let!(:all_category) { create_list(:category, 4) }
    let(:book) { create(:book, category_id: all_category.sample.id) }

    before do
      catalog_page.load
    end

    it 'shows books only from choosen category' do
      catalog_page.category_title_link(text: book.category.title).first.click
      expect(page).to have_content(book.title)
    end
  end

  context 'when sort logic' do
    let!(:count_book) { 5 }
    let(:sorting_list) { Queries::Books::SortOrder::SORTING_LIST }
    let(:sort_list_for_database) do
      {
        newest: 'created_at DESC',
        popular: 'created_at DESC',
        by_price_asc: 'price ASC',
        by_price_desc: 'price DESC',
        by_title_asc: 'title ASC',
        by_title_desc: 'title DESC'
      }
    end

    before do
      create_list(:book, count_book)
      stub_const('BooksController::BOOKS_PER_PAGE', count_book)
      visit(books_path)
    end

    it 'sorting book' do
      sorting_list.each do |sort_key, sort_value|
        catalog_page.sort_id.first.click
        click_link(sort_value, match: :first)
        database_books = Book.order(sort_list_for_database[sort_key]).map(&:title)
        catalog_books = catalog_page.title_books.map(&:text)
        expect(catalog_books).to eq(database_books)
      end
    end
  end

  context 'with view more button' do
    before do
      create_list(:book, 2)
      stub_const('BooksController::BOOKS_PER_PAGE', 1)
      visit(books_path)
    end

    it 'shows more books' do
      expect(page).to have_selector('.title', count: 1)
      click_link(I18n.t('shop.view_more'))
      expect(page).to have_selector('.title', count: 2)
    end

    it 'hides button when all books are shown' do
      expect(page).to have_content(I18n.t('shop.view_more'))
      click_link(I18n.t('shop.view_more'))
      expect(page).not_to have_content(I18n.t('shop.view_more'))
    end
  end

  context 'when click on eye icon' do
    before do
      create(:book)
      visit(books_path)
    end

    it 'render book info page' do
      link = catalog_page.link_books.first['href']
      catalog_page.book_eye.first.click
      expect(page).to have_current_path(link)
    end
  end

  context 'when click on shopping-cart icon' do
    before do
      create(:book)
      visit(books_path)
    end

    it 'adds new line item to order' do
      expect(LineItem.count).to eq(0)
      catalog_page.shopping_cart.first.click
      expect(LineItem.count).to eq(1)
    end
  end
end
