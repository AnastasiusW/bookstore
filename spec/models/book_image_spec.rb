RSpec.describe BookImage, type: :model do
  context 'with check associations' do
    it { is_expected.to belong_to(:book).optional }
  end
end
