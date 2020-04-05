RSpec.describe BookDecorator do
  subject(:decorator) { described_class.new(book_test) }

  let(:authors) do
    [
      create(:author, first_name: 'Fenimore', last_name: 'Cooper'),
      create(:author, first_name: 'Victor ', last_name: 'Hugo')
    ]
  end

  let(:book_test) { create(:book, height: 6.4, width: 1.1, depth: 5.0, authors: authors) }

  it '#authors_names' do
    expect(decorator.authors_names).to eq('Fenimore Cooper, Victor  Hugo')
  end

  it '#dimensions' do
    expect(decorator.dimensions).to eq('H: 6.4 " x W: 1.1" x D: 5.0"')
  end
end
