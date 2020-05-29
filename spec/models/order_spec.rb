RSpec.describe Order, type: :model do
  context 'with check associations' do
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to have_many(:line_items).dependent(:destroy) }
    it { is_expected.to belong_to(:delivery).optional }
    it { is_expected.to have_one(:coupon) }
  end

  context 'with check validates' do
    it {is_expected.to validate_uniqueness_of(:number) }
  end
end
