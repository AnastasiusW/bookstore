RSpec.describe Queries::Books::SortOrder do
  subject(:service) { described_class.new(params) }

  let!(:book1) { create(:book, title: 'aaa', price: 300) }
  let!(:book2) { create(:book, title: 'bbb', price: 100) }
  let!(:book3) { create(:book, title: 'ccc', price: 200) }
  let!(:book4) { create(:book, title: 'ddd', price: 50) }

  context 'when sort in newest order' do
    let(:params) { { collection: Book.all, sort_param: :newest } }

    it { expect(service.call).to eq([book4, book3, book2, book1]) }
  end

  context 'when sort in by_title_asc order' do
    let(:params) { { collection: Book.all, sort_param: :by_title_asc } }

    it { expect(service.call).to eq([book1, book2, book3, book4]) }
  end

  context 'when sort in by_title_desc order' do
    let(:params) { { collection: Book.all, sort_param: :by_title_desc } }

    it { expect(service.call).to eq([book4, book3, book2, book1]) }
  end

  context 'when sort in by_price_asc order' do
    let(:params) { { collection: Book.all, sort_param: :by_price_asc } }

    it { expect(service.call).to eq([book4, book2, book3, book1]) }
  end

  context 'when sort in by_price_desc order' do
    let(:params) { { collection: Book.all, sort_param: :by_price_desc } }

    it { expect(service.call).to eq([book1, book3, book2, book4]) }
  end

  context 'when sort in popular order' do
    let(:params) { { collection: Book.all, sort_param: :popular } }

    before do
      create(:line_item, book: book1, quantity: 3)
      create(:line_item, book: book2, quantity: 4)
      create(:line_item, book: book3, quantity: 10)
      create(:line_item, book: book4, quantity: 5)
    end

    it { expect(service.call).to eq([book3, book4, book2, book1]) }
  end
end
