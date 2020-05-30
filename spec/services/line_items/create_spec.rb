RSpec.describe Services::LineItems::Create do
  subject(:service) { described_class.new(order: order, allowed_params: params) }

  let(:order) { create(:order) }
  let(:book) { create(:book) }

  context 'when create new line_item' do
    let(:book_quantity) { 5 }
    let(:params) { { book_id: book.id, quantity: book_quantity } }

    it 'creates new line_item' do
      expect(order.line_items.count).to eq(0)
      service.call
      expect(order.line_items.count).to eq(1)
      expect(order.line_items.first.quantity).to eq(book_quantity)
      expect(order.line_items.first.item_price).to eq(book.price)
      expect(order.line_items.first.total_price).to eq(book.price * book_quantity)
    end
  end

  context 'when update line_item' do
    let(:book_quantity) { 5 }
    let(:params) { { book_id: book.id, quantity: book_quantity } }
    let!(:current_item) { create(:line_item, book: book, order: order, quantity: 2) }

    it 'updates existing line_item' do
      expect(order.line_items.count).to eq(1)
      expect(current_item.quantity).to eq(2)
      service.call
      expect(order.line_items.count).to eq(1)
      expect(order.line_items.find_by(id: current_item).quantity).to eq(book_quantity)
      expect(order.line_items.find_by(id: current_item).total_price).to eq(book.price * book_quantity)
    end
  end
end
