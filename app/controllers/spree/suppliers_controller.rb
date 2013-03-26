class Spree::SuppliersController < Spree::BaseController
  helper 'spree/products'
  respond_to :html

  def index
    @suppliers = Spree::Supplier.all
  end

  def show
    @supplier = Supplier.find(params[:id])
    @products = Product.find(:all, :conditions => { :supplier_id => @supplier.id , :deleted_at => nil })
  end
end
