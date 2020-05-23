RSpec.describe Services::LineItems::Update do
  subject(:service) { described_class.new(allowed_params: params) }

  let(:order) { create(:order) }

  context 'when increment quantity book from 1 to 2' do
    let(:quantity) { 'increment' }
    let(:line_item) { create(:line_item, order: order, item_price: 5, total_price: 5) }
    let(:params) { { order_id: order.id, id: line_item.id, quantity_action: quantity } }

    it 'when increment' do
      service.call
      expect(LineItem.find_by(id: line_item.id).quantity).to eq(2)
      expect(LineItem.find_by(id: line_item.id).total_price).to eq(10)
    end
  end

  context 'when decrement quantity book from 2 to 1' do
    let(:quantity) { 'decrement' }
    let(:line_item) { create(:line_item, order: order, item_price: 5, total_price: 10, quantity: 2) }
    let(:params) { { order_id: order.id, id: line_item.id, quantity_action: quantity } }

    it 'when decrement' do
      service.call
      expect(LineItem.find_by(id: line_item.id).quantity).to eq(1)
      expect(LineItem.find_by(id: line_item.id).total_price).to eq(5)
    end
  end

  context 'when decrement quantity book is 2 service do not change quantity and price' do
    let(:quantity) { 'decrement' }
    let(:line_item) { create(:line_item, order: order, item_price: 5, total_price: 5, quantity: 1) }
    let(:params) { { order_id: order.id, id: line_item.id, quantity_action: quantity } }

    it 'when decrement' do
      service.call
      expect(LineItem.find_by(id: line_item.id).quantity).to eq(1)
      expect(LineItem.find_by(id: line_item.id).total_price).to eq(5)
    end
  end
end
