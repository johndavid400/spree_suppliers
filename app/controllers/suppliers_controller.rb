class SuppliersController < Spree::BaseController
  helper :products
  respond_to :html

  def index
    @search = Supplier.search(params[:search])
    @suppliers = @search.all
    respond_with(@suppliers)
  end

  def show
    @supplier = Supplier.find(params[:id])
    @products = Product.find(:all, :conditions => { :supplier_id => @supplier.id , :deleted_at => nil })
  end
end
