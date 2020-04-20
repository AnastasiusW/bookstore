RSpec.describe 'Admin authors' do
  let!(:author) { create(:author) }
  let!(:admin_user) { create(:admin_user) }
  let(:author_attributes) { attributes_for(:author) }
  let(:admin_authors_page) { AdminAuthorsPrism.new }
  let(:new_first_name) { FFaker::Name.first_name }
  let(:new_last_name) { FFaker::Name.last_name }
  let(:new_biography) { FFaker::Lorem.paragraph }
  let(:author_new) { build(:author) }

  before do
    sign_in admin_user
    visit admin_authors_path
  end

  it 'when admin create an author' do
    expect(Author.count).to eq(1)
    click_link('New Author')
    admin_authors_page.create_form(author_new)
    expect(admin_authors_page).to have_content(author_new.first_name)
    expect(admin_authors_page).to have_content(author_new.last_name)
    expect(Author.count).to eq(2)
  end

  it 'when admin view the author' do
    click_link(I18n.t('admin.authors.view'), match: :first)
    expect(admin_authors_page).to have_current_path(admin_author_path(author.id))
  end

  it 'when admin  edit the author' do
    click_link('Edit', match: :first)
    expect(admin_authors_page).to have_current_path(edit_admin_author_path(author.id))
    admin_authors_page.edit_form(new_first_name, new_last_name, new_biography)

    expect(admin_authors_page).to have_content(new_first_name)
    expect(admin_authors_page).to have_content(new_last_name)
  end

  it 'when admin delete the author' do
    expect(Author.count).to eq(1)
    admin_authors_page.accept_confirm { click_link('Delete', match: :first, visible: true) }
    expect(admin_authors_page).to have_current_path(admin_authors_path)
    expect(admin_authors_page).to have_content(I18n.t('admin.test.destroy', item: 'Author'))
    expect(Book.count).to eq(0)
  end
end
