class SignInPrism < SitePrism::Page
    set_url '/users/sign_in'
    element :name_email, "input[name='user[email]']"
    element :name_password, "input[name='user[password]']"
    element :flash_fail, '#flash_fail_id'
    element :facebook_icon, '.fa-facebook-official'

    def sign_in(email, password)
        name_email.set(email)
        name_password.set(password)
        click_button(I18n.t('authentication.login'))
    end

    def flash_fail_message
        flash_fail.text
    end

    def valid_data_facebook
        OmniAuth.config.test_mode = true
        OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(provider: 'facebook',
                                                                      uid: '123545',
                                                                      info: { email: FFaker::Internet.email })
    end



end
