RSpec.describe 'Dashboard' do
  let!(:admin_user) { create(:admin_user) }

  before do
    sign_in admin_user
    visit admin_dashboard_path
  end

  it 'when visit dashboard page' do
    expect(page).to have_content(I18n.t('active_admin.dashboard_welcome.welcome'))
    expect(page).to have_content(I18n.t('active_admin.dashboard_welcome.call_to_action'))
  end
end
