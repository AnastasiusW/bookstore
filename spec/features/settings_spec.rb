describe 'Settings', type: :feature do
  let(:user) { create(:user, :with_addresses) }
  let(:settings_page) { AddressPrivacyPrism.new }
  let(:home_page) { HomePage.new }

  before do
    sign_in user
    visit edit_user_path(user)
    settings_page.load(user_id: user.id)
  end

  describe 'when choose Address tab' do
    let(:valid_address_data) { build(:address) }
    let(:invalid_address_data) do
      build(:address,
            first_name: FFaker::Random.rand(0..9),
            last_name: FFaker::Random.rand(0..9),
            city: FFaker::Random.rand(0..9),
            country: FFaker::Random.rand(0..9),
            address: '',
            zip: FFaker::Lorem.word,
            phone: FFaker::Lorem.word)
    end

    context 'when user already have billing address ' do
      it 'when billiing address already exists' do
        expect(settings_page.billing_address_section.billing_first_name.value).to eq(user.billing_address.first_name)
        expect(settings_page.billing_address_section.billing_last_name.value).to eq(user.billing_address.last_name)
        expect(settings_page.billing_address_section.billing_country_name.value).to eq(user.billing_address.country)
        expect(settings_page.billing_address_section.billing_city_name.value).to eq(user.billing_address.city)
        expect(settings_page.billing_address_section.billing_zip_name.value.to_i).to eq(user.billing_address.zip)
        expect(settings_page.billing_address_section.billing_phone_name.value).to eq(user.billing_address.phone)
      end

      it 'when updates users billing data with valid data  ' do
        settings_page.fill_in_billing_address_form(valid_address_data)
        expect(settings_page.flash_success_message).to have_content(I18n.t('notification.success.address.update', type: 'billing_address'))
      end

      it 'when updates users billing data with invalid data  ' do
        settings_page.fill_in_billing_address_form(invalid_address_data)
        expect(settings_page.flash_fail_message).to have_content(I18n.t('notification.fail.address.error_one'))
      end
    end

    context 'when user have not billing address' do
      let(:user) { create(:user) }
      let(:empty_field) { '' }

      it 'when billiing address not exists' do
        expect(settings_page.billing_address_section.billing_first_name.value).to eq(empty_field)
        expect(settings_page.billing_address_section.billing_last_name.value).to eq(empty_field)
        expect(settings_page.billing_address_section.billing_city_name.value).to eq(empty_field)
        expect(settings_page.billing_address_section.billing_country_name.value).to eq('AF')
        expect(settings_page.billing_address_section.billing_address_name.value).to eq(empty_field)
        expect(settings_page.billing_address_section.billing_zip_name.value).to eq(empty_field)
        expect(settings_page.billing_address_section.billing_phone_name.value).to eq(empty_field)
      end

      it 'when create new billing address with valid date' do
        settings_page.fill_in_billing_address_form(valid_address_data)
        expect(settings_page.flash_success_message).to have_content(I18n.t('notification.success.address.update', type: 'billing_address'))
      end

      it 'when create new billing address with invalid date' do
        settings_page.fill_in_billing_address_form(invalid_address_data)
        expect(settings_page.flash_fail_message).to have_content(I18n.t('notification.fail.address.error_one'))
      end
    end

    context 'when shipping address ' do
      it 'when shipping address already exists' do
        expect(settings_page.shipping_address_section.shipping_first_name.value).to eq(user.shipping_address.first_name)
        expect(settings_page.shipping_address_section.shipping_last_name.value).to eq(user.shipping_address.last_name)
        expect(settings_page.shipping_address_section.shipping_country_name.value).to eq(user.shipping_address.country)
        expect(settings_page.shipping_address_section.shipping_city_name.value).to eq(user.shipping_address.city)
        expect(settings_page.shipping_address_section.shipping_zip_name.value.to_i).to eq(user.shipping_address.zip)
        expect(settings_page.shipping_address_section.shipping_phone_name.value).to eq(user.shipping_address.phone)
      end

      it 'when updates users shipping data with valid data  ' do
        settings_page.fill_in_shipping_address_form(valid_address_data)
        expect(settings_page.flash_success_message).to have_content(I18n.t('notification.success.address.update', type: 'shipping_address'))
      end

      it 'when updates users shipping data with invalid data  ' do
        settings_page.fill_in_shipping_address_form(invalid_address_data)
        expect(settings_page.flash_fail_message).to have_content(I18n.t('notification.fail.address.error_one'))
      end
    end

    context 'when user have not shipping address' do
      let(:user) { create(:user) }
      let(:empty_field) { '' }

      it 'when shippiing address not exists' do
        expect(settings_page.shipping_address_section.shipping_first_name.value).to eq(empty_field)
        expect(settings_page.shipping_address_section.shipping_last_name.value).to eq(empty_field)
        expect(settings_page.shipping_address_section.shipping_city_name.value).to eq(empty_field)
        expect(settings_page.shipping_address_section.shipping_country_name.value).to eq('AF')
        expect(settings_page.shipping_address_section.shipping_address_name.value).to eq(empty_field)
        expect(settings_page.shipping_address_section.shipping_zip_name.value).to eq(empty_field)
        expect(settings_page.shipping_address_section.shipping_phone_name.value).to eq(empty_field)
      end

      it 'when create new shipping address with valid date  ' do
        settings_page.fill_in_shipping_address_form(valid_address_data)
        expect(settings_page.flash_success_message).to have_content(I18n.t('notification.success.address.update', type: 'shipping_address'))
      end

      it 'when create new shipping data with invalid data  ' do
        settings_page.fill_in_shipping_address_form(invalid_address_data)
        expect(settings_page.flash_fail_message).to have_content(I18n.t('notification.fail.address.error_one'))
      end
    end
  end

  describe 'when choose Privacy tab' do
    before do
      click_link(I18n.t('settings_form.privacy_tab'))
    end

    context 'when updating Email' do
      let(:new_email) { FFaker::Internet.email }

      it 'changes users email' do
        settings_page.change_email(new_email)
        expect(settings_page.flash_success_message).to have_content(I18n.t('notification.success.settings.update'))
      end
    end

    context 'when updating Password' do
      let(:new_password) { FFaker::Internet.password }
      let(:invalid_password) { '1' }
      let(:invalid_password_confirmation) { '2' }

      it 'when user put valid data' do
        settings_page.change_password(user.password, new_password)
        expect(settings_page).to have_current_path(root_path)
        expect(home_page.flash_success_message).to have_content(I18n.t('notification.success.settings.update'))
      end

      it 'when user put invalid data' do
        settings_page.change_password(invalid_password, invalid_password_confirmation)
        expect(settings_page.flash_fail_message).to have_content(I18n.t('notification.fail.settings.password_update'))
      end
    end
  end

  describe 'when delete Account' do
    context 'when user want delete account' do
      before do
        click_link(I18n.t('settings_form.privacy_tab'))
      end

      it 'click checkbox destroy' do
        settings_page.account_detail.delete_account.first.click
        settings_page.account_detail.button_destroy.click
        expect(settings_page).to have_current_path(root_path)
        expect(home_page.flash_success_message).to have_content(I18n.t('devise.registrations.destroyed'))
        expect(User.count).to eq(0)
      end
    end
  end
end
