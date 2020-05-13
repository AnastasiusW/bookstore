RSpec.describe ReviewPolicy do
  subject { described_class.new(user, review) }

  let!(:review) { create(:review) }

  context 'with user' do
    let(:user) { create(:user) }

    it { is_expected.to permit_action(:create) }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
  end

  context 'with guest' do
    let(:user) { nil }

    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
  end
end
