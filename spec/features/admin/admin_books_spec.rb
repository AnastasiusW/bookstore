RSpec.describe 'Admin Books' do
    let!(:book) {create(:book)}
    let!(:admin_user){create(:admin_user)}
    let(:admin_books_page) {AdminBooksPrism.new }
    let(:book_new) {build(:book)}
    before do
      sign_in admin_user
      visit admin_books_path
    end

    it 'when admin create a book' do
      expect(Book.count).to eq(1)
      click_link('New Book')
      admin_books_page.fill_form(book_new,book)
      expect(admin_books_page).to have_content(book_new.title)
      expect(Book.count).to eq(2)
    end


  it 'when admin click view the book' do
    click_link('View', match: :first)
    expect(admin_books_page).to have_current_path(admin_book_path(book.id))
  end

  it 'when admin delete the book' do
    expect(Book.count).to eq(1)
    admin_books_page.accept_confirm{ click_link('Delete', match: :first, visible: true)}
    expect(admin_books_page).to have_current_path(admin_books_path)
    expect(admin_books_page).to have_content(I18n.t('admin.test.destroy',item: "Book"))
    expect(Book.count).to eq(0)
  end
end
