RSpec.describe LineItemPolicy do
  subject { described_class.new(CurrentContext.new(user,order), current_item) }

  let!(:current_item) { create(:line_item,order: order) }
  let!(:order) {create(:order)}

  context 'with user' do
    let(:user) { create(:user) }
    it { is_expected.to permit_action(:destroy) }
    it { is_expected.to permit_action(:update) }
  end
  context 'with guest' do
    let(:user) { nil }
    it { is_expected.to permit_action(:destroy) }
    it { is_expected.to permit_action(:update) }
  end
end
