RSpec.describe Services::Coupons::Apply do
  subject(:service) { described_class.new(order: order, params: params) }

  let(:order) { create(:order) }
  let(:params) { { code: coupon.code } }

  context 'when coupon is active ' do
    let(:coupon) { create(:coupon) }

    it 'when apply coupon to order' do
      service.call
      expect(order.coupon).to eq(coupon)
    end
  end

  context 'when coupon is not active ' do
    let(:coupon) { create(:coupon, active: false) }

    it 'when can not apply coupon to order' do
      expect(service.call).to eq(false)
      expect(order.coupon).to eq(nil)
    end
  end
end
