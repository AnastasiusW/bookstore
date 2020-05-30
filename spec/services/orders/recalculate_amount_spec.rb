RSpec.describe Services::Orders::RecalculateAmount do
  subject(:service) { described_class.new(order.id) }

  context 'when order has line_items, coupon and delivery price ' do
    let(:order) { create(:order, delivery: delivery) }
    let(:delivery) { create(:delivery, price: 20) }

    before do
      create(:line_item, order: order, item_price: 100, total_price: 200, quantity: 2)
      create(:line_item, order: order, item_price: 100, total_price: 100, quantity: 1)
      create(:coupon, order: order, discount_amount: 10)
    end

    it 'calculate total  price of line_items, coupon, delivery and  subtotal price of line_items' do
      expect(Order.find_by(id: order.id).total_price).to eq(0)
      expect(Order.find_by(id: order.id).subtotal_price).to eq(0)
      service.call
      expect(Order.find_by(id: order.id).total_price).to eq(290)
      expect(Order.find_by(id: order.id).subtotal_price).to eq(300)
    end
  end

  context 'when order has line_items, coupon price ' do
    let(:order) { create(:order) }

    before do
      create(:line_item, order: order, item_price: 100, total_price: 200, quantity: 2)
      create(:line_item, order: order, item_price: 100, total_price: 100, quantity: 1)
      create(:coupon, order: order, discount_amount: 10)
    end

    it 'calculate total  price of line_items, coupon and subtotal price of line_items ' do
      expect(Order.find_by(id: order.id).total_price).to eq(0)
      expect(Order.find_by(id: order.id).subtotal_price).to eq(0)
      service.call
      expect(Order.find_by(id: order.id).total_price).to eq(270)
      expect(Order.find_by(id: order.id).subtotal_price).to eq(300)
    end
  end

  context 'when order has line_items price ' do
    let(:order) { create(:order) }

    before do
      create(:line_item, order: order, item_price: 100, total_price: 200, quantity: 2)
      create(:line_item, order: order, item_price: 100, total_price: 100, quantity: 1)
    end

    it 'calculate total price of line_items  and subtotal price of line_items' do
      expect(Order.find_by(id: order.id).total_price).to eq(0)
      expect(Order.find_by(id: order.id).subtotal_price).to eq(0)
      service.call
      expect(Order.find_by(id: order.id).total_price).to eq(300)
      expect(Order.find_by(id: order.id).subtotal_price).to eq(300)
    end
  end

  context 'when order has line_items and delivery price ' do
    let(:order) { create(:order, delivery: delivery) }
    let(:delivery) { create(:delivery, price: 20) }

    before do
      create(:line_item, order: order, item_price: 100, total_price: 200, quantity: 2)
      create(:line_item, order: order, item_price: 100, total_price: 100, quantity: 1)
    end

    it 'calculate total price of line_items, delivery  and subtotal price of line_items ' do
      expect(Order.find_by(id: order.id).total_price).to eq(0)
      expect(Order.find_by(id: order.id).subtotal_price).to eq(0)
      service.call
      expect(Order.find_by(id: order.id).total_price).to eq(320)
      expect(Order.find_by(id: order.id).subtotal_price).to eq(300)
    end
  end

  context 'when order does not have any line_items ' do
    let(:order) { create(:order) }

    it 'order is empty or the last item has been deleted, the price is reseted to zero' do
      expect(Order.find_by(id: order.id).line_items.empty?).to eq(true)
      expect(Order.find_by(id: order.id).total_price).to eq(0)
      expect(Order.find_by(id: order.id).subtotal_price).to eq(0)
      expect(service.call).to eq(true)
      expect(Order.find_by(id: order.id).line_items.empty?).to eq(true)
      expect(Order.find_by(id: order.id).total_price).to eq(0)
      expect(Order.find_by(id: order.id).subtotal_price).to eq(0)
    end
  end
end
