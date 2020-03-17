RSpec.describe User, type: :model do
  context 'with check validates' do
    it 'when valid  email' do
      expect(build(:user, email: FFaker::Internet.email)).to be_valid
    end

    it 'when invalid  email' do
      expect(build(:user, email: nil)).not_to be_valid
    end
  end
end
