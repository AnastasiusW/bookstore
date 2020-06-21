class CurrentContext
  attr_reader :user, :foo

  def initialize(user, foo)
    @user = user
    @foo = foo
  end
end
