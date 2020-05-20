class LineItemsController < ApplicationController
  def index
    @presenter = Presenters::LineItems::Index.new(current_order)
  end

  def create
    Services::LineItems::Create.new(order: current_order, allowed_params: line_items_params).call
    flash[:success] = I18n.t('cart_block.success')
  end

  def update
    Services::LineItems::Update.new(allowed_params: line_items_params).call
    redirect_to order_line_items_path(current_order)
  end

  def destroy
    Services::LineItems::Destroy.new(allowed_params: line_items_params).call
    redirect_to order_line_items_path(current_order)
  end

  private

  def line_items_params
    params.permit(:book_id, :quantity, :order_id, :id, :quantity_action)
  end
end
