RSpec.describe ReviewForm, type: :model do
  context 'when presence validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:comment) }
    it { is_expected.to validate_presence_of(:rating) }
  end

  context 'when input valid data' do
    let(:valid_title) { FFaker::Lorem.word }
    let(:valid_comment) { FFaker::Lorem.paragraph }
    let(:valid_rating) { rand(1..5) }

    it { is_expected.to allow_value(valid_title).for(:title) }
    it { is_expected.to allow_value(valid_comment).for(:comment) }
    it { is_expected.to allow_value(valid_rating).for(:rating) }
  end

  context 'when input valid data' do
    let(:invalid_title) { '' }
    let(:invalid_comment) { '' }
    let(:invalid_rating) { 10 }

    it { is_expected.not_to allow_value(invalid_title).for(:title) }
    it { is_expected.not_to allow_value(invalid_comment).for(:comment) }
    it { is_expected.not_to allow_value(invalid_rating).for(:rating) }
  end

  context 'when save form' do
    let!(:review_params) { attributes_for(:review, book_id: book.id, user_id: user.id) }
    let!(:user) { create(:user) }
    let!(:book) { create(:book) }
    let!(:review_form) { described_class.new(review_params) }

    it 'when review save with success' do
      expect(Review.count).to eq(0)
      review_form.save
      expect(Review.count).to eq(1)
    end

    it 'when review save with fail' do
      expect(Review.count).to eq(0)
      allow(review_form).to receive(:valid?).and_return(false)
      review_form.save
      expect(Review.count).to eq(0)
    end
  end
end
