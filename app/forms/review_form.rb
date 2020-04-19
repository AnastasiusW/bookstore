class ReviewForm
    include ActiveModel::Model
    include Virtus.model

    MAX_TITLE_LENGTH = 80
    MAX_BODY_LENGTH = 500
    MIN_RATING = 1
    MAX_RATING = 5
    VALIDATE_TITLE = /\A[a-zA-Z0-9 \!\#\$\%\&\'\*\+\-\/\=\?\^\-\`\{\}\|\,\.]*\z/.freeze
    VALIDATE_BODY = /\A[a-zA-Z0-9 \!\#\$\%\&\'\*\+\-\/\=\?\^\-\`\{\}\|\,\.]*\z/.freeze


    attribute :title, String
    attribute :comment, String
    attribute :rating, Integer
    attribute :book_id, Integer
    attribute :user_id, Integer

    validates :title, presence: true, length: { maximum: MAX_TITLE_LENGTH  }, format: { with: VALIDATE_TITLE }
    validates :comment, presence: true, length: { maximum:  MAX_BODY_LENGTH }, format: { with: VALIDATE_BODY}
    validates :rating,presence: true, numericality: { greater_than_or_equal_to: MIN_RATING, less_than_or_equal_to: MAX_RATING }

    def save
        return false unless valid?
        Review.create(attributes)
    end

end
