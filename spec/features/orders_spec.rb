RSpec.describe 'Orders', type: :feature do
  let(:user) { create(:user, :with_credit_card) }
  let(:order_page) { OrderPage.new }
  let(:deliveries) { create_list(:delivery, 3) }

  before do
    (1..5).map do |status|
      create(:order, :with_line_items, :order_addresses, status: status, user: user, delivery: deliveries.first)
    end

    sign_in user
    visit root_path
    order_page.load
  end

  context 'when sort logic' do
    let(:sorting_list) { Queries::Orders::Index::ALLOWED_STATUS }

    it 'sort order by status' do
      sorting_list.each do |sort_key, sort_value|
        order_page.sort_id.first.click
        click_link(sort_value, match: :first)
        database_order = Order.where(status: sort_key).map(&:number)
        order_list = order_page.number_order.first.text
        expect([order_list]).to eq(database_order)
      end
    end
  end

  context 'when click on number' do
    it 'redirect to order details page' do
      number = order_page.number_order.first.text

      link = find_link(number)['href']
      order_page.number_order.first.click
      expect(order_page).to have_current_path(link)
    end
  end
end
