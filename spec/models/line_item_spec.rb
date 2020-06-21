RSpec.describe LineItem, type: :model do
  context 'with check associations' do
    it { is_expected.to belong_to(:order).optional }
    it { is_expected.to belong_to(:book) }
  end

  context 'with check validates' do
    it { validate_numericality_of(:quantity) }
  end
end
