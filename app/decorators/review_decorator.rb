class ReviewDecorator < Draper::Decorator
    delegate_all
    decorates_association :user

    def rating
        @object.rating
    end

    def empty_stars
        ReviewForm::MAX_RATING - @object.rating
    end

    def name
        user.name_to_avatar
    end

    def date_comment
        @object.created_at.to_date
    end

    def name_author
        user.full_name
    end

end
