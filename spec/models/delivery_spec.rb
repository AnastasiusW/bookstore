RSpec.describe Delivery, type: :model do
  context 'with check associations' do
    it { is_expected.to have_many(:orders) }
  end
end
