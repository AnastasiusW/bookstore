class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    process_review
  end

  private

  def review_params
    params.require(:review).permit(:title, :comment, :user_id, :book_id, :rating)
  end

  def process_review
    review_form = ReviewForm.new(review_params)
    authorize Review.new, :create?
    if review_form.save
      flash[:notice] = I18n.t('notification.success.reviews.create')
    else
      flash[:alert] = review_form.errors.full_messages.join(', ')
    end
    redirect_to book_path(review_params[:book_id])
  end
end
