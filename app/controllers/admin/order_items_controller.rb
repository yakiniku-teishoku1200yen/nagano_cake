class Admin::OrderItemsController < ApplicationController
  
  def update
   @order_item = OrderItem.find(params[:id])
   @order = @order_item.order
   @order_items = @order.order_items
   @order_item.update(order_items_params)
    if params[:order_item][:crafting_status] == "production"
      @order.update(status: "In_production")
    end
    if @order_items.count == @order_items.where(crafting_status: "production_completed").count
      @order.update(status: "Preparing_to_ship")
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_items_params
    params.require(:order_item).permit( :crafting_status)
  end

end
