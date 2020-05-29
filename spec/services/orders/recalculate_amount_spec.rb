RSpec.describe Services::Orders::RecalculateAmount do
  subject(:service) { described_class.new(order.id) }

  context 'when order have line_items, coupon and delivery price ' do
    let(:order) { create(:order, delivery: delivery) }
    let(:delivery) { create(:delivery, price: 20) }

    before do
      create(:line_item, order: order, item_price: 100, total_price: 200, quantity: 2)
      create(:line_item, order: order, item_price: 100, total_price: 100, quantity: 1)
      create(:coupon, order: order, discount_amount: 10)
    end

    it 'when order have line_items, coupon and delivery price ' do
      service.call
      expect(Order.find_by(id: order.id).total_price).to eq(290)
      expect(Order.find_by(id: order.id).subtotal_price).to eq(300)
    end
  end

  context 'when order have line_items, coupon price ' do
    let(:order) { create(:order) }

    before do
      create(:line_item, order: order, item_price: 100, total_price: 200, quantity: 2)
      create(:line_item, order: order, item_price: 100, total_price: 100, quantity: 1)
      create(:coupon, order: order, discount_amount: 10)
    end

    it 'when order have line_items, coupon  price ' do
      service.call
      expect(Order.find_by(id: order.id).total_price).to eq(270)
      expect(Order.find_by(id: order.id).subtotal_price).to eq(300)
    end
  end

  context 'when order have line_items price ' do
    let(:order) { create(:order) }

    before do
      create(:line_item, order: order, item_price: 100, total_price: 200, quantity: 2)
      create(:line_item, order: order, item_price: 100, total_price: 100, quantity: 1)
    end

    it 'when order have line_items price' do
      service.call
      expect(Order.find_by(id: order.id).total_price).to eq(300)
      expect(Order.find_by(id: order.id).subtotal_price).to eq(300)
    end
  end

  context 'when order have line_items and delivery price ' do
    let(:order) { create(:order, delivery: delivery) }
    let(:delivery) { create(:delivery, price: 20) }

    before do
      create(:line_item, order: order, item_price: 100, total_price: 200, quantity: 2)
      create(:line_item, order: order, item_price: 100, total_price: 100, quantity: 1)
    end

    it 'when order have line_items delivery price ' do
      service.call
      expect(Order.find_by(id: order.id).total_price).to eq(320)
      expect(Order.find_by(id: order.id).subtotal_price).to eq(300)
    end
  end

  context 'when line_items do not exist ' do
    let(:order) { create(:order) }

    it 'when line_items do not exist' do
      expect(service.call).to eq(nil)
    end
  end
end
