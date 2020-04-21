RSpec.describe 'Review', type: :feature do
let!(:book) {create(:book)}

let!(:user) {create(:user)}

let(:review_page) { ReviewPrism.new }

context 'when user sign in' do
    let(:valid_title) {FFaker::Book.unique.title}
    let(:valid_comment) {FFaker::Lorem.paragraph}
    let(:stars) { rand(1..5)}
    let(:invalid_title) {'<>'}
    let(:invalid_comment) {'<>'}

    before do
        sign_in user
        visit(book_path(book))
    end

    it 'when user input valid data in review form' do
        expect(Review.count).to eq(0)
        review_page.fill_in_review_form_valid_data(rating: stars,title: valid_title, comment: valid_comment)
        expect(review_page).to have_content(I18n.t('notification.success.reviews.create'))
        expect(Review.count).to eq(1)

    end

    it 'when user input invalid data in review form' do
        review_page.fill_in_review_form_invalid_data(title: invalid_title, comment: invalid_comment)
        expect(review_page).to have_content(I18n.t('test_error.review_errors'))
    end
end
    context 'when user  not sign in' do
        before do
            visit(book_path(book))
        end

        it {expect(review_page).not_to have_field("review_page.review_name_title")}

        it { expect(review_page).not_to have_field("review_page.review_name_comment") }

        it { expect(review_page).not_to have_content("review_page.review_button")}


    end

    context 'when review has 3 status' do
        let!(:review) {create(:review, book: book, user: user)}

        it 'when users can see unprocessed reviews' do
            review.unprocessed!
            visit(book_path(book))
            expect(review_page).not_to have_content(review.comment)
        end

        it 'when users can see approved reviews' do
            review.approved!
            visit(book_path(book))
            expect(review_page).to have_content(review.comment)
        end

        it 'when users can see rejected reviews' do
            review.rejected!
            visit(book_path(book))

            expect(review_page).not_to have_content(review.comment)
        end
    end
end
