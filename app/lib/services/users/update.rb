module Services
  module Users
    class Update
      def initialize(current_user:, user_params:)
        @user = current_user
        @params = user_params
      end

      def success?
        @params[:current_password].present? ? @user.update_with_password(@params) : @user.update(@params)
      end
    end
  end
end
