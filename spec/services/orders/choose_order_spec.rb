RSpec.describe Services::Orders::ChooseOrder do
  subject(:service) { described_class.new(order.id, user) }

  context 'when order_id and user is nil' do
    let(:order) { build(:order, id: nil, user_id: nil) }
    let(:user) { nil }

    it 'creates new Order' do
      expect(Order.count).to eq(0)
      service.call
      expect(Order.count).to eq(1)
      expect(Order.first.line_items.empty?).to eq true
    end
  end

  context 'when  user is nil' do
    let!(:order) { create(:order, user_id: nil) }
    let(:user) { nil }

    it 'return existing order without user, quantity of order do not changed' do
      expect(Order.count).to eq(1)
      expect(service.call.user_id).to eq nil
      expect(Order.count).to eq(1)
      expect(Order.find(order.id).line_items.empty?).to eq true
    end
  end

  context 'when user exists and signed and order exists' do
    let!(:order) { create(:order, user_id: user.id) }
    let(:user) { create(:user) }

    it 'return existing order with user, quantity of order do not changed' do
      expect(Order.count).to eq(1)
      expect(service.call.user_id).to eq(order.user_id)
      expect(Order.count).to eq(1)
      expect(Order.find(order.id).line_items.empty?).to eq true
    end
  end

  context 'when order_id is nil and user exists' do
    let(:order) { build(:order, user_id: user.id) }
    let(:user) { create(:user) }

    it 'creates order with user_id' do
      expect(Order.count).to eq(0)
      expect(service.call.user_id).to eq(order.user_id)
      expect(Order.count).to eq(1)
      expect(Order.first.line_items.empty?).to eq true
    end
  end
end
