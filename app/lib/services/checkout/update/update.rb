module Services
  module Checkout
    module Update
      class Update
        def initialize(order:, billing:, shipping:, use:)
          @current_order = order
          @billing_params = billing
          @shipping_params = shipping
          @use_billing = use[:use_billing_address]
        end

        def call(step)
          case step
          when :address then manage_address
          end
        end

        def manage_address
          Services::Checkout::Update::Address.new(order: @current_order, billing: @billing_params, shipping: @shipping_params, use_billing: @use_billing).call
        end
      end
    end
  end
end
