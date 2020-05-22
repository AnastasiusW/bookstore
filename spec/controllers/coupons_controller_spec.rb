RSpec.describe CouponsController, type: :controller do
  let(:order) {create(:order)}
  before do
   allow(controller).to receive(:current_order).and_return(order)
  end
  context 'when valid code coupon' do
    let(:coupon){create(:coupon)}

    it 'when valid coupon' do
      post :create, params: {code: coupon.code}
      expect(order.coupon).to eq(coupon)
      expect(response).to redirect_to(order_line_items_path(order.id))
      expect(response.status).to eq 302
    end
  end

  context 'when invalid code coupon' do
    let(:code_fake) { FFaker::Lorem.word }
    it 'when valid coupon' do
      post :create, params: {code: code_fake}
      expect(order.coupon).to be_nil
      expect(response).to redirect_to(order_line_items_path(order.id))
      expect(response.status).to eq 302
    end
  end

  context 'when not activated  coupon' do
    let(:coupon){create(:coupon, active: false)}
    it 'when valid coupon' do
      post :create, params: {code: coupon.code}
      expect(order.coupon).to be_nil
      expect(response).to redirect_to(order_line_items_path(order.id))
      expect(response.status).to eq 302
    end
  end
end
