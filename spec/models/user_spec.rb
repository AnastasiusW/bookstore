RSpec.describe User, type: :model do
  context 'with check validates' do
    it { is_expected.to validate_presence_of(:email) }
  end

  context 'with check associations' do
    it { is_expected.to have_one(:credit_card).dependent(:destroy) }
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
    it { is_expected.to have_many(:orders).dependent(:destroy) }
  end
end
