class ReviewDecorator < Draper::Decorator
  delegate_all
  decorates_association :user

  def rating
    review.rating
  end

  def empty_stars
    ReviewForm::MAX_RATING - review.rating
  end

  def name
    user.name_to_avatar
  end

  def verify_review
    review.user.orders.exists?(status: :delivered)
  end

  def date_comment
    review.created_at.to_date
  end
end
