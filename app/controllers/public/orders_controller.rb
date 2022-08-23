class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
  end

  def index
    @orders = current_customer.orders.page(params[:page]).per(10)
    @total_items = Item.count
  end

  def show
    @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: @order.id)
    #@total = @order.total_payment - @order.shipping_cost
    @total_money = 0
  end

  def confirm
    @total_money = 0
    @order = Order.new(order_params)
     if params[:order][:select_address] == 'own_address'
           @order.post_code = current_customer.post_code
           @order.address = current_customer.address
           @order.name = current_customer.full_name
     elsif  params[:order][:select_address] == 'registered_address'
           @address = Address.find(params[:order][:address_id])
           @order.post_code = @address.post_code
           @order.address = @address.shipping_address
           @order.name = @address.name
     else #バリデーションチェック
     end
    @order.shipping_cost = 800
    @select_address = params[:order][:select_address]
    @cart_items = CartItem.where(customer_id: current_customer.id)
    #@cart_items = current_customer.cart_items
  end

  def thanks
  end

  def create
    cart_items = current_customer.cart_items
    @order = current_customer.orders.new(order_params)
    if @order.save
    current_customer.cart_items.all.each do |cart_item|
      order_item = OrderItem.new
      order_item.item_id = cart_item.item_id
      order_item.order_id = @order.id
      order_item.order_quantity = cart_item.amount
      order_item.price = cart_item.amount
      order_item.save
    end
    redirect_to thanks_path
    cart_items.destroy_all
    else
    @order = Order.new(order_params)
    render :new
    end
  end


  def order_params
    params.require( :order).permit( :payment_method, :post_code, :address, :name ,:total_payment ,:shipping_cost)
  end
end
