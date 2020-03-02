RSpec.describe Book, type: :model do
  before { build(:book) }

  context 'with check associations' do
    it 'belongs to category' do
     should belong_to(:category)
    end

    it 'have and belong to many authors' do
      should have_many(:authors)
    end
  end

  context 'with check validates' do
    %w[title description price quantity year].each do |field|
      it { should validate_presence_of(field) }
    end

    %w[width height depth].each do |field|
      it {should validate_numericality_of(field).is_greater_than(0) }
    end

    it 'is valid with correct price' do
      should validate_numericality_of(:price).is_greater_than(0)
    end
  end
end
