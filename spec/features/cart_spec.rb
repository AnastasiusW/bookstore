RSpec.describe 'Cart', type: :feature do
  let!(:book) {create(:book)}
  let(:current_order) {Order.first.id}
  let(:cart_page) { CartPage.new }

  before do
    cart_page.load
    click_link(I18n.t('home.buy_now'))
    visit order_line_items_path(current_order)
  end

  context 'when increment and decrement quantity book' do
    let(:expect_after_increment) {2}
    let(:expect_after_decrement) {1}

    before do
      cart_page.plus_link.first.click
    end

    it 'when increment quantity book in cart' do
     expectation = cart_page.input_quantity.first[:value]
     expect(expectation).to have_text(expect_after_increment)
     end

    it 'when decrement quantity book in cart' do

     cart_page.minus_link.first.click
     expectation = cart_page.input_quantity.first[:value]

     expect(expectation).to have_text(expect_after_decrement)
    end
  end

  context 'when  delete lineitem' do
    it 'when delete book' do
      expect(LineItem.count).to eq(1)
      find("#button_delete#{LineItem.first.id}", match: :first).click

      expect(LineItem.count).to eq(0)
      expect(cart_page.flash_success_message).to have_content(I18n.t('line_item.destroy_success'))
    end
  end
  context 'when click to link to view info about book' do
    it 'when click on image book' do
      cart_page.link_view_book_on_image.first.click
      expect(cart_page).to have_current_path book_path(book)
    end
    it 'when click on title book' do
      click_link(book.title,match: :first)

      expect(cart_page).to have_current_path book_path(book)
    end
end


context 'when click on apply coupon button' do

  let!(:coupon_active) {create(:coupon)}
  let!(:coupon_not_active) {create(:coupon, active: false)}

  let(:wrong_code) {FFaker::Lorem.word}

  it 'when coupon valid and active' do
    cart_page.coupon_name.set(coupon_active.code)

    click_on(I18n.t('coupon.button'),match: :first)
    expect(cart_page).to have_current_path order_line_items_path(current_order)
    expect(cart_page).to have_content(I18n.t('coupon.applied'))
    expect(cart_page.flash_success_message).to have_content(I18n.t('coupon.applied'))

  end

  it 'when coupon valid and not active' do
    cart_page.coupon_name.set(coupon_not_active.code)

    click_on(I18n.t('coupon.button'),match: :first)
    expect(cart_page).to have_current_path order_line_items_path(current_order)
    expect(cart_page.flash_fail_message).to have_content(I18n.t('coupon.not_applied'))
  end

  it 'when coupon invalid and active' do
    cart_page.coupon_name.set(wrong_code)


    click_on(I18n.t('coupon.button'),match: :first)
    expect(cart_page).to have_current_path order_line_items_path(current_order)
    expect(cart_page.flash_fail_message).to have_content(I18n.t('coupon.not_applied'))
  end


end

end
