ActiveAdmin.register Review do
  permit_params :title, :comment, :rating, :status

  scope :unprocessed, default: true
  scope :approved
  scope :rejected
  index do
    selectable_column
    column :book
    column :title
    column :created_at
    column :user
    column :status
    column :actions do |review|
      link_to(t('admin.reviews.show'), admin_review_path(review))
    end
  end

  action_item :approve, only: :show do
    link_to I18n.t('admin.reviews.approved'), approve_admin_review_path, method: :put
  end
  action_item :reject, only: :show do
    link_to t('admin.reviews.rejected'), reject_admin_review_path, method: :put
  end

  member_action :approve, method: :put do
    review = Review.find(params[:id])
    review.approved!
    redirect_to admin_review_path(review), notice: I18n.t('admin.reviews.status.approved')
  end

  member_action :reject, method: :put do
    review = Review.find(params[:id])
    review.rejected!
    redirect_to admin_review_path(review), notice: I18n.t('admin.reviews.status.rejected')
  end
end
