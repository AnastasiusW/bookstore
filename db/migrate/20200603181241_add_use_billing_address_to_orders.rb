class AddUseBillingAddressToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :use_billing_address, :boolean, default: false
  end
end
