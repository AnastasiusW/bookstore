module Presenters
  class Address
    def initialize(current_instance:)
      @current_instance = current_instance
    end

    def billing
      @current_instance.billing_address || BillingAddress.new
    end

    def shipping
      @current_instance.shipping_address || ShippingAddress.new
    end

    def method_billing_address
      @current_instance.billing_address ? :patch : :post
    end

    def method_shipping_address
      @current_instance.shipping_address ? :patch : :post
    end

    def order_billing_address
      return @current_instance.billing_address if @current_instance.billing_address
      return @current_instance.user.billing_address if @current_instance.user.billing_address

      BillingAddress.new
    end

    def order_shipping_address
      return @current_instance.shipping_address if @current_instance.shipping_address
      return @current_instance.user.shipping_address if @current_instance.user.shipping_address

      ShippingAddress.new
    end
  end
end
