class QuickRegistrationsController < ApplicationController

  def new
    @user = User.new
  end

  def create

    @user = User.new(set_params)
    @user.skip_confirmation!
    if @user.save
      sign_in(@user)
      @user.send_reset_password_instructions
      flash[:notice] = I18n.t('checkout.login.success')
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
    end
    redirect_to root_path
  end

  def set_params
    {email: params[:user][:email], password: Devise.friendly_token[0, 10]}
  end


end
