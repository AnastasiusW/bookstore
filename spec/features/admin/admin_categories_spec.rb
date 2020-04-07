RSpec.describe 'Admin Categories' do
    let!(:category) {create(:category)}
    let!(:admin_user){create(:admin_user)}
    let(:admin_categories_page) {AdminCategoriesPrism.new }
    let(:category_new) { build(:category) }
    let(:new_title) {FFaker::Book.genre}


    before do
      sign_in admin_user
      visit admin_categories_path
    end

    it 'when admin create category' do
        expect(Category.count).to eq(1)
        click_link('New Category')
        admin_categories_page.create_form(category_new)

        expect(admin_categories_page).to have_content(category_new.title)
        expect(Category.count).to eq(2)
    end

    it 'when admin  view the category' do
        click_link('View', match: :first)
        expect(admin_categories_page).to have_current_path(admin_category_path(category.id))
    end
    it 'when admin edit category' do
        click_link('Edit', match: :first)
        admin_categories_page.edit_form(new_title)

        expect(admin_categories_page).to have_content(new_title)
      end

      it 'when admin delete the category' do
        expect(Category.count).to eq(1)
        admin_categories_page.accept_confirm{ click_link('Delete', match: :first, visible: true)}
         expect(admin_categories_page).to have_current_path(admin_categories_path)
         expect(admin_categories_page).to have_content(I18n.t('admin.test.destroy', item: "Category"))
        expect(Category.count).to eq(0)
      end

end
