RSpec.describe CreditCard, type: :model do
  describe 'ith check associations' do
    it { is_expected.to belong_to(:user) }
  end
end
