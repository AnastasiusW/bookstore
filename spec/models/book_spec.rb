RSpec.describe Book, type: :model do
  subject(:current_book) { build(:book) }

  context 'with check associations' do
    it 'belongs to category' do
      expect(current_book).to belong_to(:category)
    end

    it 'have and belong to many authors' do
      expect(current_book).to have_many(:authors)
    end
  end

  context 'with check validates' do
    %w[title description price quantity year].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    %w[width height depth].each do |field|
      it { is_expected.to validate_numericality_of(field).is_greater_than_or_equal_to(1) }
    end

    it 'is valid with correct price' do
      expect(current_book).to validate_numericality_of(:price).is_greater_than_or_equal_to(5)
    end
  end
end
