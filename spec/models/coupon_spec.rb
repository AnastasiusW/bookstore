RSpec.describe Coupon, type: :model do
  context 'with check associations' do
    it { is_expected.to belong_to(:order).optional }
  end
end
