RSpec.describe Book, type: :model do
  subject { build(:book) }

  context 'with check associations' do
    it 'belongs to category' do
      expect(subject).to belong_to(:category)
    end

    it 'have and belong to many authors' do
      expect(subject).to have_many(:authors)
    end
  end

  context 'with check validates' do
    %i[title description price quantity year].each do |field|
      it { expect(subject).to validate_presence_of(field) }
    end

    %i[width height depth].each do |field|
      it { expect(subject).to validate_numericality_of(field).is_greater_than(0) }
    end

    it 'is invalid with incorrect price' do
      expect(build(:book, price: -1)).not_to be_valid
      expect(build(:book, price: 'price')).not_to be_valid
    end

    it 'is valid with correct price' do
      expect(build(:book, price: 100)).to be_valid
    end
  end
end
