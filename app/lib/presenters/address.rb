module Presenters
    class Address
        def initialize(current_user:)
            @current_user = current_user
        end

        def billing
            @current_user.billing_address || BillingAddress.new
        end

        def shipping
            @current_user.shipping_address || ShippingAddress.new
        end

        def method_billing_address
            return :patch if @current_user.billing_address
            :post
        end

        def method_shipping_address
            return :patch if @current_user.shipping_address
            :post
        end
    end
end
