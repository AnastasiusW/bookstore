require 'rails_helper'

RSpec.feature "Homes", type: :feature do

  before do
    visit(root_path)
  end

  context 'must contain title Best_sellers' do
    it 'it contain title best_sellers' do
      expect(page).to have_content(I18n.t('home.best_sellers'))
  end
end

end
