class ReviewsController < ApplicationController
    before_action :authenticate_user!
def create
    review_form = ReviewForm.new(review_params)
    if review_form.save
        flash[:notice] = I18n.t('notification.success.reviews.create')
    else
        flash[:alert] = review_form.errors.full_messages.join(', ')
    end
    redirect_to book_path(review_params[:book_id])
end

private
    def review_params
        params.require(:review).permit(:title, :comment, :user_id, :book_id, :rating)
    end
end
