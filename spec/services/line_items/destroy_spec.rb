RSpec.describe Services::LineItems::Destroy do
  subject(:service) { described_class.new(allowed_params: params) }

  let(:order) { create(:order, subtotal_price: 5, total_price: 5) }

  context 'when destroy item with success' do


    let!(:line_item) { create(:line_item, order: order, item_price: 5, total_price: 5) }
    let(:params) { { order_id: order.id, id: line_item.id } }

    it 'when destroy item' do
      expect(LineItem.count).to eq(1)
      service.call
      expect(LineItem.count).to eq(0)
    end
  end

  context 'when destroy item with fails' do
    let(:line_item) { create(:line_item, order: order, item_price: 5, total_price: 5) }
    let(:params) { { order_id: order.id, id: nil } }

    it 'test will fall because the parameter id is nil ' do
      expect(service.call).to eq(false)
    end
  end
end
