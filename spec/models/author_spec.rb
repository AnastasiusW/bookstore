RSpec.describe Author, type: :model do
  context 'with check associations' do
    it { is_expected.to have_many(:books) }
  end

  %w[first_name last_name].each do |field|
    it { is_expected.to validate_presence_of(field) }
  end
end
