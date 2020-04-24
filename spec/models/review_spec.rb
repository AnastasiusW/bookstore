RSpec.describe Review, type: :model do
  context 'with check associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end
end
