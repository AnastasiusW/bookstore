class CouponsController < ApplicationController

  def create
     if Services::Coupons::Apply.new(order: current_order, params: coupon_params).call
      flash[:notice] = I18n.t('coupon.applied')
     else
      flash[:alert] = I18n.t('coupon.not_applied')
     end
     redirect_to order_line_items_path(current_order)
  end

  def coupon_params
    params.permit(:code)
  end
end
