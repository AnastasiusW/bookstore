class UserDecorator < Draper::Decorator
    delegate_all
    def name_to_avatar

            email.first.capitalize
    end

    def full_name
        email
    end






end
