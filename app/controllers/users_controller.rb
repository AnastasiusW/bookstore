class UsersController < ApplicationController
  before_action :authenticate_user!
  def edit
    @presenter = Presenters::Address.new(current_user: current_user)
  end

  def update
    updata_info = Services::Users::UpdateService.new(current_user: current_user, user_params: user_params)
    choose_strategy(updata_info)
  end

  def destroy
    current_user.destroy
    redirect_to root_path, notice: I18n.t('devise.registrations.destroyed')
  end

  private

  def user_params
    params.require(:user).permit(:email, :current_password, :password, :password_confirmation)
  end

  def choose_strategy(updata_info)
    if updata_info.update_success?
      flash[:notice] = I18n.t('notification.success.settings.update')
      redirect_to root_path
    else
      flash[:alert] = current_user.errors.full_messages.to_sentence
      redirect_to edit_user_path(current_user)
    end
  end
end
