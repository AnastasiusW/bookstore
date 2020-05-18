RSpec.describe Services:: Orders::ChooseOrder do
  subject(:service) { described_class.new(order.id, user) }

  context 'when order_id and user is nill service create new Order' do
  let!(:order) {build(:order, id: nil, user_id: nil)}
  let!(:user) {nil}

    it 'when order_id(session[:order_id] is nil and user_id(not sign or guest) is nill)' do
      expect(Order.count).to eq(0)
      service.call
      expect(Order.count).to eq(1)
    end
  end

  context 'when  user is nill' do
    let!(:order) {create(:order, user_id: nil)}
    let!(:user) {nil}

      it 'when order have not user_id' do
        expect(Order.count).to eq(1)
        expect(service.call.user_id).to eq nil
        expect(Order.count).to eq(1)
      end
  end
  context 'when user is exist and sign in and order exist' do
    let!(:order) {create(:order, user_id: user.id)}
    let!(:user) {create(:user)}

      it 'when order  have user_id' do
        expect(Order.count).to eq(1)
        expect(service.call.user_id).to eq(order.user_id)
        expect(Order.count).to eq(1)
      end
  end

  context 'when order_id is nill and user_id exist' do
    let!(:order) {build(:order, user_id: user.id)}
    let!(:user) {create(:user)}

      it 'when create order with user_id' do
        expect(Order.count).to eq(0)
        expect(service.call.user_id).to eq(order.user_id)
        expect(Order.count).to eq(1)
      end
  end
end
