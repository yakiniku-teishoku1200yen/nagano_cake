class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @genres = Genre.all
    @total_items = Item.all
    @items = Item.page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private

  def items_params
    parmas.require(:item).permit(:genre_id, :name, :explanation, :price, :is_ordered, :image)
  end

end
