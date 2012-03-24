class SuppliersController < Spree::BaseController
  helper 'spree/products'
  respond_to :html

  def index
    @search = Spree::Supplier.search(params[:search])
    @suppliers = @search.all
    respond_with(@suppliers)
  end

  def show
    @supplier = Spree::Supplier.find(params[:id])
    @products = Spree::Product.find(:all, :conditions => { :supplier_id => @supplier.id , :deleted_at => nil })
  end
end
