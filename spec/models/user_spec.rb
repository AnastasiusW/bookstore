RSpec.describe User, type: :model do
  context 'with check validates' do
    it { is_expected.to validate_presence_of(:email) }
  end
end
