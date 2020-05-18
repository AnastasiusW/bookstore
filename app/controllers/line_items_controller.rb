class LineItemsController < ApplicationController

  def index
    Services::Orders::AmountCalculation.new(current_order).calculate_subtotal_order
    binding.pry
  end


  def create
    Services::LineItems::Create.new(order: current_order, allowed_params: line_items_params).call
    flash[:success] = I18n.t('cart_block.success')

  end

  private

  def line_items_params
    params.permit(:book_id, :quantity)
  end

end
