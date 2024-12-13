RSpec.describe 'Homes', type: :feature do
  let(:count_book) { Book::LATEST_BOOK_COUNT }
  let(:home_page) { HomePage.new }

  context 'when get started click button and slider' do
    before do
      create_list(:book, 5)
      home_page.load
    end

    it 'open catalog when click get started' do
      click_link(I18n.t('home.get_started'))
      expect(home_page).to have_current_path(books_path)
    end

    it 'have latest books' do
      within '#slider' do
        expect(home_page).to have_selector('.item', visible: false, count: count_book)
      end
    end
  end

  context 'when inside bestsellers' do
    let(:category1) { create(:category) }
    let(:category2) { create(:category) }
    let(:category3) { create(:category) }
    let(:category4) { create(:category) }
    let(:category5) { create(:category) }

    let(:book1) { create(:book, category: category1) }
    let(:book2) { create(:book, category: category1) }

    let(:book3) { create(:book, category: category2) }
    let(:book4) { create(:book, category: category2) }

    let(:book5) { create(:book, category: category3) }
    let(:book6) { create(:book, category: category3) }

    let(:book7) { create(:book, category: category4) }
    let(:book8) { create(:book, category: category4) }
    let(:order) { create(:order, status: :in_delivery) }

    before do
      create(:line_item, quantity: 5, book: book1, order: order)
      create(:line_item, quantity: 1, book: book2, order: order)
      create(:line_item, quantity: 5, book: book2, order: order)

      create(:line_item, quantity: 1, book: book3, order: order)
      create(:line_item, quantity: 5, book: book4, order: order)

      create(:line_item, quantity: 2, book: book5, order: order)
      create(:line_item, quantity: 1, book: book6, order: order)
      create(:line_item, quantity: 3, book: book6, order: order)

      create(:line_item, quantity: 10, book: book7, order: order)
      create(:line_item, quantity: 1, book: book8, order: order)
      home_page.load
    end

    it 'must have 4 beatsellers book' do
      expect(home_page).to have_selector('.general-thumb-link-wrap', visible: false, count: 4)
    end

    it 'redirect to book view info' do
      link = home_page.link_books.first['href']

      home_page.book_eye.first.click
      expect(home_page).to have_current_path(link)
    end

    it 'adds book to card' do
      home_page.shopping_cart.first.click
    end
  end

  context 'when footer, click to ' do
    let(:user) { create(:user) }

    before do
      sign_in user
      home_page.load
    end

    it 'home link and redirect to home page' do
      find(text: I18n.t('default.homepage'), class: 'link-footer').click
      expect(home_page).to have_current_path(root_path)
    end

    it 'order link and redirect to order page' do
      find(text: I18n.t('default.orders'), class: 'link-footer').click
      expect(home_page).to have_current_path(orders_path)
    end

    it 'shop link and redirect to caralog page' do
      find(text: I18n.t('default.shop'), class: 'link-footer').click
      expect(home_page).to have_current_path(books_path)
    end

    it 'settings link and redirect to order page' do
      find(text: I18n.t('default.settings'), class: 'link-footer').click
      expect(home_page).to have_current_path(edit_user_path(user))
    end
  end

  context 'when user is not signed' do
    before do
      home_page.load
    end

    it 'click to sign_in in menu' do
      click_on(I18n.t('default.login'))

      expect(home_page).to have_current_path(new_user_session_path)
    end

    it 'click to sign_up in menu' do
      click_on(I18n.t('default.sign_up'))

      expect(home_page).to have_current_path(new_user_registration_path)
    end
  end

  context 'when user is  signed' do
    let(:user) { create(:user) }

    before do
      sign_in user
      home_page.load
    end

    it 'click to settings link in menu and will be redirect to settings page' do
      click_on(I18n.t('default.settings'))

      expect(home_page).to have_current_path(edit_user_path(user))
    end

    it 'click to order link in memu and will be redirect to orders page' do
      click_on(I18n.t('default.orders'))

      expect(home_page).to have_current_path(orders_path)
    end
  end

  context 'when click on cart icon' do
    before do
      home_page.load
    end

    it 'redirect to cart page' do
      find(class: 'shop-link').click

      expect(home_page).to have_current_path(order_line_items_path(Order.first))
    end
  end
end
