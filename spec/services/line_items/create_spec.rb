RSpec.describe Services::LineItems::Create do
  subject(:service) {described_class.new(order: order, allowed_params: params)}
  let(:order) { create(:order) }
  let(:book) { create(:book) }

  context 'when create new line_item' do
    let(:params) { { book_id: book.id, quantity: 5} }
    it 'when create line_item' do
      expect(order.line_items.count).to eq(0)
      result = service.call
      expect(order.line_items.count).to eq(1)
      expect(result.quantity).to eq(5)
    end
  end

  context 'when update line_item' do
      let(:params) { { book_id: book.id, quantity: 5} }
      let(:current_item) {create(:line_item,book: book, order: order, quantity: 2)}

    it 'when update line_item' do
      expect(current_item.quantity).to eq(2)
      service.call
      expect(order.line_items.count).to eq(1)
      expect(order.line_items.find_by(id:current_item).quantity).to eq(5)
    end
  end
end
