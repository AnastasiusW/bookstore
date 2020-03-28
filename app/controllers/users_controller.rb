class UsersController < ApplicationController
    before_action :authenticate_user!
    def edit
        @presenter = Presenters::Address.new(current_user: current_user)
    end


    def update
        if  user_params[:current_password].present? ? current_user.update_with_password(user_params) : current_user.update(user_params)
          redirect_to edit_user_path, notice: I18n.t('notification.success.settings.update')
        else
            render :edit
        end
    end

    def destroy
        current_user.destroy
        redirect_to root_path, notice: I18n.t('devise.registrations.destroyed')
    end

    private

    def user_params
        params.require(:user).permit(:email, :current_password, :password, :password_confirmation)
      end
end
