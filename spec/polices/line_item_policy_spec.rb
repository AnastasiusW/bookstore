RSpec.describe LineItemPolicy do
  subject { described_class.new(CurrentContext.new(user, order), current_item) }

  let!(:current_item) { create(:line_item, order: order) }
  let!(:order) { create(:order) }

  context 'with user' do
    let(:user) { create(:user) }

    it { is_expected.to permit_action(:destroy) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
  end

  context 'with guest' do
    let(:user) { nil }

    it { is_expected.to permit_action(:destroy) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
  end
end
