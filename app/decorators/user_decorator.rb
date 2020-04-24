class UserDecorator < Draper::Decorator
    delegate_all
    def name_to_avatar

            email.first.capitalize
    end








end
