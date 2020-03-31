module Services
  module Users
    class UpdateService
      def initialize(current_user:, user_params:)
        @user = current_user
        @params = user_params
      end

      def update_success?
        @params[:current_password].present? ? @user.update_with_password(@params) : @user.update(@params)
      end
    end
  end
end
