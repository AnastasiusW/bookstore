RSpec.describe ReviewsController, type: :controller do
    let!(:user) { create(:user) }
    let!(:book) {create(:book)}
    let(:valid_params) {{review:attributes_for(:review, book_id: book.id, user_id: user.id)}}
    let(:invalid_params) { {review: { book_id: book.id, title: '', comment: '' } }}

    before do
        sign_in user
    end

    describe 'POST #create' do
    it 'when user create review with success' do
        post :create, params: valid_params

        expect(response).to redirect_to(book_path(book))
        expect(flash[:notice]).to eq(I18n.t('notification.success.reviews.create'))
    end

    it 'when user create review with fails' do
        post :create, params: invalid_params
        expect(response).to redirect_to(book_path(book))
        is_expected.to set_flash[:alert]
    end

end

end
