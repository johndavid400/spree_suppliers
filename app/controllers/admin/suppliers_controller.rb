class Admin::SuppliersController < Admin::BaseController
  resource_controller
  respond_to :html, :js

  def index
    if current_user.has_role?("admin")
      @suppliers = Supplier.all
    else
      @supplier = current_user.supplier
    end
  end

  def new
    @supplier = Supplier.new()
    @supplier.images.build
    @status = true
  end

  def create
    @supplier = Supplier.new(params[:supplier])
    if @supplier.save
      redirect_to admin_suppliers_path, :notice => "New supplier created"
    else
      render "new"
    end
  end

  def show
    @supplier = Supplier.find(params[:id])
  end

  def edit
    @supplier = Supplier.find(params[:id])
    @supplier.images.build
  end

  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy
    flash[:notice] = "Supplier Successfully deleted."
    respond_with(@product) do |format|
      format.html { redirect_to collection_url }
      format.js do
        render :update do |page|
          page.redirect_to collection_url
        end
      end
    end
  end

  def update
    @supplier = Supplier.find(params[:id])
    @status = false
    if @supplier.update_attributes(params[:supplier])
      redirect_to edit_admin_supplier_path, :notice => "Supplier updated"
    else
      render "edit"
    end
  end

  def feature
    @supplier = Supplier.find(params[:supplier_id])
    if @supplier.featured == true
      @supplier.featured = false
    else
      @supplier.featured = true
    end
    @supplier.save
    flash[:notice] = "change #{@supplier.title}'s feature status to #{@supplier.featured}"
    redirect_to admin_suppliers_path
  end

  def line_items
    @order = Order.find_by_number(params[:order_id])
  end

  def selected
    @supplier = @product.supplier
  end

  def available
    if params[:q].blank?
      @available_suppliers = []
    else
      @available_suppliers = Supplier.find(:all, :conditions => ['lower(name) LIKE ?', "%#{params[:q].downcase}%"])
    end
    @available_suppliers.delete_if { |supplier| @product.supplier == supplier }
    respond_to do |format|
      format.html
      format.js {render :layout => false}
    end

  end

  def remove
    @product.supplier = nil
    @product.save
    @supplier = @product.supplier
    render :layout => false
  end

  def select
    @supplier = Supplier.find_by_param!(params[:id])
    @product.supplier = @supplier
    @product.save
    @supplier = @product.supplier
    render :layout => false
  end


  update.response do |wants|
    wants.html { redirect_to collection_url }
  end

  update.after do
    Rails.cache.delete('suppliers')
  end

  create.response do |wants|
    wants.html { redirect_to collection_url }
  end

  create.after do
    Rails.cache.delete('suppliers')
  end

end
