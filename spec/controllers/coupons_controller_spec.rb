RSpec.describe CouponsController, type: :controller do
  let(:order) { create(:order) }

  before do
    session['order_id'] = order.id
  end

  context 'when valid code coupon' do
    let(:coupon) { create(:coupon) }

    it 'existing active coupon with valid code apply to order, will be success' do
      post :create, params: { code: coupon.code }
      expect(order.coupon).to eq(coupon)
      expect(response).to redirect_to(order_line_items_path(order.id))
      expect(response.status).to eq 302
    end
  end

  context 'when invalid code coupon' do
    let(:code_fake) { FFaker::Lorem.word }

    it 'existing active coupon with invalid code try to apply to order, сoupon does not apply to order' do
      post :create, params: { code: code_fake }
      expect(order.coupon).to be_nil
      expect(response).to redirect_to(order_line_items_path(order.id))
      expect(response.status).to eq 302
    end
  end

  context 'when not activated  coupon' do
    let(:coupon) { create(:coupon, active: false) }

    it 'existing not active coupon with valid code try to apply to order, сoupon does not apply to order' do
      post :create, params: { code: coupon.code }
      expect(order.coupon).to be_nil
      expect(response).to redirect_to(order_line_items_path(order.id))
      expect(response.status).to eq 302
    end
  end
end
