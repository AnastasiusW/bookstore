RSpec.describe 'Books', type: :feature, js: true do
  let(:book) { create(:book, description: FFaker::Book.description(rand(4..10))) }
  let!(:book_page) { BookPrism.new }

  before do
    visit(book_path(book))
  end

  context 'with description' do
    it 'show full description' do
      first('.in-gold-500').hover
      click_link(I18n.t('book.read_more'))
      expect(page).to have_content(book.description)
    end
  end

  context 'with price calculator' do
    it 'show case when increment count book' do
      book_page.plus.click
      expect(book_page.id_quantity.value).to eq('2')
    end

    it 'show case when decrement count book' do
      book_page.minus.click
      expect(book_page.id_quantity.value).to eq('1')
    end
  end

  context 'with add book when click cart button' do
    it 'when increment count book' do
      expect(LineItem.count).to eq(0)
      book_page.plus.click
      expect(book_page.id_quantity.value).to eq('2')
      book_page.add_to_cart_button.click
      expect(LineItem.count).to eq(1)
      expect(LineItem.find_by(book_id: book.id).quantity).to eq(2)
    end
  end
end
