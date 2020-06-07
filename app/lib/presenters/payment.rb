module Presenters
  class Payment
    def initialize(current_instance:)
      @current_instance = current_instance
    end

    def check_credit_card
      @current_instance.user.credit_card || CreditCardForm.new
    end
  end
end
