class Spree::SuppliersController < Spree::BaseController
  respond_to :html

  def index
    @q = Supplier.search(params[:q])
    @suppliers = @q.result
    respond_with(@suppliers)
  end

  def show
    @supplier = Supplier.find(params[:id])
    @products = Spree::Product.find(:all, :conditions => { :supplier_id => @supplier.id , :deleted_at => nil })
  end
end
