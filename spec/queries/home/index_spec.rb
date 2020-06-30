RSpec.describe Queries::Home::Index do
  subject(:service) { described_class }

  let(:category1) { create(:category) }
  let(:category2) { create(:category) }
  let(:category3) { create(:category) }
  let(:category4) { create(:category) }

  let(:book1) { create(:book, category: category1) }
  let(:book2) { create(:book, category: category1) }

  let(:book3) { create(:book, category: category2) }
  let(:book4) { create(:book, category: category2) }

  let(:book5) { create(:book, category: category3) }
  let(:book6) { create(:book, category: category3) }

  let(:book7) { create(:book, category: category4) }
  let(:book8) { create(:book, category: category4) }

  let(:order) { create(:order, status: :in_delivery) }
  let(:order2) { create(:order, status: :delivered) }

  before do
    create(:line_item, quantity: 5, book: book1, order: order)
    create(:line_item, quantity: 1, book: book2, order: order)
    create(:line_item, quantity: 5, book: book2, order: order)

    create(:line_item, quantity: 1, book: book3, order: order)
    create(:line_item, quantity: 5, book: book4, order: order)

    create(:line_item, quantity: 2, book: book5, order: order)
    create(:line_item, quantity: 1, book: book6, order: order2)
    create(:line_item, quantity: 3, book: book6, order: order)

    create(:line_item, quantity: 10, book: book7, order: order2)
    create(:line_item, quantity: 1, book: book8, order: order)
  end

  it 'return the most popular book from each category' do
    expect(service.call).to match_array([book2, book4, book6, book7])
  end
end
