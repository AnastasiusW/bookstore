RSpec.describe Queries::Books::Index do
  subject(:service) { described_class.new(params) }

  let!(:category1) { create(:category) }
  let!(:category2) { create(:category) }
  let!(:book1) { create(:book, category: category1) }
  let!(:book2) { create(:book, category: category2) }
  let!(:book3) { create(:book, category: category2) }

  context 'when empty params' do
    let(:params) { { category_id: '' } }

    it 'return all book in all category' do
      expect(service.call).to match_array([book1, book2, book3])
    end
  end

  context 'when not empty params' do
    let(:params) { { category_id: category2.id } }

    it 'return all book in all category' do
      expect(service.call).to match_array([book2, book3])
    end
  end
end
