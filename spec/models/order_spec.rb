RSpec.describe Order, type: :model do
  context 'with check associations' do
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to have_many(:line_items).dependent(:destroy) }
  end
end
