class Admin::SuppliersController < Admin::BaseController
  resource_controller
  helper :dragonfly
  before_filter :load_edit, :only => [:edit]
  before_filter :load_data, :only => [:selected, :available, :remove, :new, :edit, :select]
  respond_to :html, :js

  def new
    @supplier = Supplier.new()
    @status = true
  end

  def business_hours
    days = {}
    ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"].each do |day|
      if params["#{day}_closed"] == "Closed"
        days.merge!({day.downcase.to_sym => "Closed"})
      elsif params["#{day}_closed"] == "Unavailable"
        days.merge!({day.downcase.to_sym => "Information Unavailable"})
      else
        days.merge!({day.downcase.to_sym => params["#{day}_begin"] + ":" + params["#{day}_begin_mins"] + " " + params["#{day}_begin_type"].upcase + " to " + params["#{day}_end"] + ":" + params["#{day}_end_mins"] + " " + params["#{day}_end_type"].upcase} )
      end
    end
    days
  end

  def create
    @supplier = Supplier.new(params[:supplier])
    if @supplier.save
      @supplier.hours.create(business_hours)
      redirect_to admin_suppliers_path, :notice => "New supplier created"
    else
      render "new"
    end
  end

  def show
    @supplier = Supplier.find(params[:id])
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
      @supplier.hours.first.update_attributes(business_hours)
      redirect_to edit_admin_supplier_path, :notice => "Supplier updated"
    else
      render "edit"
    end
  end



  def upload_image
    @supplier = Supplier.find(params[:image][:viewable_id])
    @supplier.images.create(params[:image])
    if @supplier.save
      redirect_to edit_admin_supplier_path(@supplier), :notice => "New supplier image uploaded successfully"
    else
      render "new"
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
    flash[:notice] = "Change #{@supplier.title}'s feature status to #{@supplier.featured}"
    redirect_to admin_suppliers_path
  end

  def make_logo
    @image = Image.find(params[:id])
    @supplier = Supplier.find(@image.viewable_id)
    @supplier.images.each do |image|
      image.logo = false
      image.save
    end
    @image.logo = true
    @image.save
    redirect_to :back, :notice => "Change which image is considered a logo."
  end

  def feature_image
    @image = Image.find(params[:id])
    @supplier = Supplier.find(@image.viewable_id)
    @supplier.images.each do |image|
      image.featured = false
      image.save
    end
    @image.featured = true
    @image.save
    redirect_to :back, :notice => "Change which image is featured."
  end


  def destroy_image
    @image = Image.find(params[:id])

    if @image.destroy
      redirect_to :back, :notice => "Image destroyed."
    else
      render "new"
    end
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

  private

  def load_data
    if !Country.first.nil?
      default_country = Country.find_by_name("United States")
      @states = default_country.states.sort
    end
    @product = Product.find_by_permalink(params[:product_id])
  end
  
  def load_edit 
    @closed = ["Unavailable", "Closed", "Open"]
    @hours = (1..12).to_a
    @minutes = ["00", "15", "30", "45"]
    @periods = ["AM","PM"]
  end
end
