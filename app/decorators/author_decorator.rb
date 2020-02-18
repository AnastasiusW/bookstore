class AuthorDecorator < Draper::Decorator
  delegate_all

  def full_name
    "#{firstname} #{lastname}"
  end

end
