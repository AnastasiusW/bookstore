class LineItemsController < ApplicationController
  def index
    @presenter = Presenters::LineItems::Index.new(current_order)
  end

  def create
    if Services::LineItems::Create.new(order: current_order, allowed_params: line_items_params).call
      flash[:notice] = I18n.t('cart_block.success')
    else
      flash[:alert] = I18n.t('cart_block.fail')
    end
  end

  def update
    set_line_item
    if Services::LineItems::Update.new(allowed_params: line_items_params).call
      flash[:notice] = I18n.t('cart_block.item_success_update')
    else
      flash[:alert] = I18n.t('cart_block.item_fail_update')
    end
    redirect_to order_line_items_path(current_order)
  end

  def destroy
    set_line_item
    Services::LineItems::Destroy.new(allowed_params: line_items_params).call
    flash[:notice] = I18n.t('line_item.destroy_success')
    redirect_to order_line_items_path(current_order)
  end

  private

  def set_line_item
    @line_item =  LineItem.find_by(id: line_items_params[:id], order_id: line_items_params[:order_id])
    authorize @line_item
  end

  def line_items_params
    params.permit(:book_id, :quantity, :order_id, :id, :quantity_action)
  end
end
