require 'rails_helper'

RSpec.describe Author, type: :model do
  before { build(:author) }

  context 'with check associations' do
    it { should have_many(:books) }
  end

  %w[firstname lastname].each do |field|
    it { should validate_presence_of(field) }
  end
end
