RSpec.describe 'Admin review' do
    let!(:admin_user) { create(:admin_user) }
    let!(:review) { create(:review) }
    before  do
        sign_in  admin_user

    end
    context 'when on review page' do
    before do
        visit admin_reviews_path
    end
    it 'when admin click show on review' do

        click_link(I18n.t('admin.reviews.show'), match: :first)
        expect(page).to have_current_path(admin_review_path(review))
      end
    end

    context 'when admin change status of reviews' do
        before do
        visit admin_review_path(review)
        end

        it 'when admin set status approved' do
            click_link(I18n.t('admin.reviews.approved'))
            expect(page).to have_content(I18n.t('admin.reviews.status.approved'))
        end

        it 'when admin set status rejected' do
            click_link(I18n.t('admin.reviews.rejected'))
            expect(page).to have_content(I18n.t('admin.reviews.status.rejected'))
        end
    end
end
