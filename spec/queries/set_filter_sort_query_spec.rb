RSpec.describe SetFilterSortQuery do
  let(:result) { described_class.call(params) }
  let(:params) { {} }
  let!(:first_book) { create(:book, title: 'AAAAA', price: 1) }
  let!(:second_book) { create(:book, title: 'BBBBB', price: 2) }
  let!(:third_book) { create(:book,title:'CCCCC',price:3) }




  context 'with filtering books' do
    let(:params) { { category_id: third_book.category_id } }

    it 'returns books from chosen category' do
      expect(result).to match_array([third_book])
    end
  end

  context 'with sorting parameter title ASC' do
    let(:params) { { sort_param: 'title ASC' } }
    it 'returns books in chosen order title ASC' do
      expect(result).to eq([first_book, second_book, third_book])
    end
  end
  context 'with sorting parameter title DESC' do
    let(:params) { { sort_param: 'title DESC' } }
    it 'returns books in chosen order title DESC' do
      expect(result).to eq([ third_book,second_book,first_book])

    end
  end

  context 'with sorting parameter price ASC' do
    let(:params) { { sort_param: 'price ASC' } }
    it 'returns books in chosen order price ASC' do
      expect(result).to eq([first_book, second_book, third_book])

    end
  end
  context 'with sorting parameter price DESC' do
    let(:params) { { sort_param: 'price DESC' } }
    it 'returns books in chosen order price DESC' do
      expect(result).to eq([third_book, second_book, first_book])
    end
  end

  context 'without sorting parameter' do
    it 'returns books in default order created_at DESC' do
      expect(result).to eq([third_book, second_book, first_book])
    end
  end

end
