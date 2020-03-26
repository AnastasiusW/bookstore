RSpec.describe 'Log out', type: :feature do
  let!(:user) { create(:user) }

  context 'when user log out' do
    it 'when user click log out button' do
      sign_in user
      visit(root_path)
      click_link(user.email, match: :first, visible: true)
      click_link(I18n.t('default.logout'), match: :first, visible: true)
      expect(page).to have_current_path(root_path)
      expect(page).to have_content(I18n.t('devise.sessions.signed_out'))
    end
  end
end
