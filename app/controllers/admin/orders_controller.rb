class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @total = 0
    @order.shipping_cost = 800
  end

  def update
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    if @order.update(order_params)
      if  params[:order][:status] == "payment_confirmation"#
        @order_items.each do |order_item|
          order_item.crafting_status = "waiting_for_production"
          order_item.save
        end
      end
    redirect_to admin_order_path(@order)
    end
  end

  private

  def order_params
    params.require(:order).permit( :status)
  end

end
