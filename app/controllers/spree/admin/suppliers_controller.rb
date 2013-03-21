class Spree::Admin::SuppliersController < Spree::Admin::ResourceController
  respond_to :html, :js
  update.after :expire_cache
  create.after :expire_cache

  def index
    if current_user.has_role?("admin")
      @suppliers = Spree::Supplier.all
    else
      @supplier = current_user.supplier
    end
  end

  def new
    @supplier = Spree::Supplier.new()
    @supplier.images.build
    @status = true
  end

  def create
    @supplier = Spree::Supplier.new(params[:supplier])
    if @supplier.save
      image = @supplier.images.create(:attachment => params[:image].tempfile)
      redirect_to spree.admin_suppliers_path, :notice => "New supplier created"
    else
      render "new"
    end
  end

  def show
    @supplier = Spree::Supplier.find(params[:id])
  end

  def edit
    @supplier = Spree::Supplier.find(params[:id])
    @supplier.images.build
  end

  def destroy
    @supplier = Spree::Supplier.find(params[:id])
    @supplier.destroy
    flash[:notice] = "Supplier Successfully deleted."
    respond_with(@supplier) do |format|
      format.html { redirect_to collection_url }
      format.js do
        render :update do |page|
          page.redirect_to collection_url
        end
      end
    end
  end

  def update
    @supplier = Spree::Supplier.find(params[:id])
    @status = false
    if @supplier.update_attributes(params[:supplier])
      redirect_to spree.edit_admin_supplier_path, :notice => "Supplier updated"
    else
      render "edit"
    end
  end

  def feature
    @supplier = Spree::Supplier.find(params[:supplier_id])
    if @supplier.featured == true
      @supplier.featured = false
    else
      @supplier.featured = true
    end
    @supplier.save
    flash[:notice] = "change #{@supplier.title}'s feature status to #{@supplier.featured}"
    redirect_to spree.admin_suppliers_path
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
      @available_suppliers = Spree::Supplier.find(:all, :conditions => ['lower(name) LIKE ?', "%#{params[:q].downcase}%"])
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
    @supplier = Spree::Supplier.find_by_param!(params[:id])
    @product.supplier = @supplier
    @product.save
    @supplier = @product.supplier
    render :layout => false
  end

  respond_override :update => { :html => { :success => lambda { redirect_to collection_url } } }
  respond_override :create => { :html => { :success => lambda { redirect_to collection_url } } }

  private
  def expire_cache
    expire_page :controller => '/spree/suppliers', :action => 'show', :path => @object.slug
  end


end
