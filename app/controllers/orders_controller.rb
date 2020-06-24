class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    sorted_orders = Queries::Orders::Index.new(sort_param: order_params[:sort_by], user: current_user).call
    @presenter = Presenters::Orders::Index.new(orders: sorted_orders, sort_order: order_params[:sort_by])
  end

  def show
    order = Order.find_by(id: order_params[:id])
    @presenter_order = Presenters::Orders::Show.new(current_order: order)
  end

  private

  def order_params
    params.permit(:id, :sort_by)
  end
end
