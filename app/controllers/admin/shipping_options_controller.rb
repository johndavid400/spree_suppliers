class Admin::ShippingOptionsController < Admin::BaseController

  def edit
    @shipping_methods = ShippingMethod.all
    @supplier = Supplier.find(params[:id])
  end

  def create
    @supplier = Supplier.find(params[:supplier_id])
    if !params[:shipping_options].nil?
      method = ShippingMethod.find_by_id(params[:shipping_options])
      @update = true
      @supplier.shipping_methods.each do |t|
        if t.id == method.id
          @update = false
        end
      end
      if @update == true
        @supplier.shipping_methods << method
        flash[:notice] = "New shipping method added successfully."
      else
        flash[:error] = "You already offer this shipping method, nothing added."
      end
    elsif !params[:remove].nil?
      method = ShippingMethod.find_by_id(params[:remove][:id])  
      @supplier.shipping_methods.delete(method)
      flash[:notice] = "Shipping method removed successfully"
    end
    redirect_to :back
  end

end
