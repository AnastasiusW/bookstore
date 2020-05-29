RSpec.describe Services::LineItems::Update do
  subject(:service) { described_class.new(allowed_params: params) }

  let(:order) { create(:order) }

  context 'when increment quantity book from 1 to 2' do
    let(:quantity) { 'increment' }
    let(:line_item) { create(:line_item, order: order, item_price: 5, total_price: 5) }
    let(:params) { { order_id: order.id, id: line_item.id, quantity_action: quantity } }

    it 'when increment' do
      expect(LineItem.find_by(id: line_item.id).quantity).to eq(1)
      expect(LineItem.find_by(id: line_item.id).total_price).to eq(5)
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
      expect(LineItem.find_by(id: line_item.id).quantity).to eq(2)
      expect(LineItem.find_by(id: line_item.id).total_price).to eq(10)
      service.call
      expect(LineItem.find_by(id: line_item.id).quantity).to eq(1)
      expect(LineItem.find_by(id: line_item.id).total_price).to eq(5)
    end
  end

  context 'when decrement quantity book is 1, service do not change quantity and price' do
    let(:quantity) { 'decrement' }
    let(:line_item) { create(:line_item, order: order, item_price: 5, total_price: 5, quantity: 1) }
    let(:params) { { order_id: order.id, id: line_item.id, quantity_action: quantity } }

    it 'when decrement' do
      expect(LineItem.find_by(id: line_item.id).quantity).to eq(1)
      expect(LineItem.find_by(id: line_item.id).total_price).to eq(5)
      service.call
      expect(LineItem.find_by(id: line_item.id).quantity).to eq(1)
      expect(LineItem.find_by(id: line_item.id).total_price).to eq(5)
    end
  end

  context 'can not change quantity, because all params is empty' do
    let(:params) { { order_id: "", id: "", quantity_action: "" } }

    it 'service must return false' do
      expect(service.call).to eq(false)
    end
  end
end
