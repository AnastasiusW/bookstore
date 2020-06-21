RSpec.describe Services::Checkout::Delivery::Update do
  subject(:service) { described_class.new(order: order, delivery_params: delivery_params) }

  let(:order) { create(:order, delivery: delivery_one, total_price: 15, subtotal_price: 5) }
  let(:delivery_one) { create(:delivery, price: 10) }
  let(:delivery_two) { create(:delivery, price: 5) }

  before do
    create(:line_item, quantity: 1, order: order, total_price: 5, item_price: 5)
  end

  context 'when update delivery with valid param' do
    let(:delivery_params) { { delivery_id: delivery_two.id } }

    it 'service updates the delivery and recount sum' do
      expect(Order.find_by(id: order.id).delivery.method_name).to eq(delivery_one.method_name)
      expect(Order.find_by(id: order.id).total_price).to eq(15)
      expect(Order.find_by(id: order.id).subtotal_price).to eq(5)
      expect(service.call).to eq(true)
      expect(Order.find_by(id: order.id).delivery.method_name).to eq(delivery_two.method_name)
      expect(Order.find_by(id: order.id).total_price).to eq(10)
      expect(Order.find_by(id: order.id).subtotal_price).to eq(5)
    end
  end

  context 'when update delivery with invalid params' do
    let(:delivery_params) { { delivery_id: 'a' } }

    it 'service do not update the delivery and do not recount sum' do
      expect(Order.find_by(id: order.id).delivery.method_name).to eq(delivery_one.method_name)
      expect(Order.find_by(id: order.id).total_price).to eq(15)
      expect(Order.find_by(id: order.id).subtotal_price).to eq(5)
      expect(service.call).to eq(nil)
      expect(Order.find_by(id: order.id).delivery.method_name).to eq(delivery_one.method_name)
      expect(Order.find_by(id: order.id).total_price).to eq(15)
      expect(Order.find_by(id: order.id).subtotal_price).to eq(5)
    end
  end
end
