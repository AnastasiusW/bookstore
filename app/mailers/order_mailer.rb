class OrderMailer < ApplicationMailer
  def order_confirmation
    @user_name = params[:user].email
    mail(to: @user_name, subject: I18n.t('mail.title'))
  end
end
