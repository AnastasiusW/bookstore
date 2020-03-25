class UsersController < ApplicationController
    before_action :authenticate_user!
    def edit
        @presenter = Presenters::Address.new(current_user: current_user)
    end
end
