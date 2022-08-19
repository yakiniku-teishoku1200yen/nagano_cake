class Public::AddressesController < ApplicationController
  def new
   @address = Address.new
  end
  
 
  def create
   @address = Address.new(address_params)
   #@address.customer_id = 1
   @address.customer_id = current_customer.id
   if @address.save
     flash[:notice] = "登録が完了しました"
     redirect_to addresses_path
   else
     @addresses = Address.all
     render :index
   end
  end
   
  
  
  def index
    @addresses = Address.all
    @address = Address.new
    #@address_find = Address.find(params[:id])
  end

  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "更新が完了しました"
      redirect_to addresses_path
    else
      @addresses = Address.find(params[:id])
      render :edit
    end
  end
  
  def destroy
    @address = Address.find(params[:id])
    if @address.destroy
    flash[:notice] = "削除が完了しました"
    redirect_to addresses_path
    end
  end
  
  def address_params
    params.require(:address).permit( :post_code, :shipping_address, :name)
  end
  
end
