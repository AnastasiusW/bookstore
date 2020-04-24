RSpec.describe ReviewDecorator do
  subject(:decorator) { described_class.new(review) }

  let(:user) { create(:user, email: 'nastya@gmail.com') }
  let(:current_rating) { 3 }
  let(:review) { create(:review, rating: current_rating, user: user) }

  it 'when check rating' do
    expect(decorator.rating).to eq(current_rating)
  end

  it 'when check empty_stars' do
    expect(decorator.empty_stars).to eq(2)
  end

  it 'when check name' do
    expect(decorator.name).to eq('N')
  end

  it 'when check verify_review' do
    create(:order, user: user, status: :delivered)
    expect(decorator.verify_review).to eq(true)
  end

  it 'when check date_comment' do
    expect(decorator.date_comment).to eq(review.created_at.to_date)
  end
end
