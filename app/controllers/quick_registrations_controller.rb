class QuickRegistrationsController < ApplicationController

  def new
    redirect_to checkout_path(:address) if user_signed_in?
    @user = User.new
  end

  def create
    @user = User.new(set_params)
    @user.skip_confirmation!
    if @user.save
      sign_in(@user)
        @user.send_reset_password_instructions
      redirect_to checkout_path(:address), notice: I18n.t('checkout.login.success')
    else
      redirect_to new_quick_registration_path, alert:  @user.errors.full_messages.to_sentence
    end
  end

  def set_params
    {email: params[:user][:email], password: Devise.friendly_token[0, 10]}
  end
end
