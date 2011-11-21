class SuppliersController < Spree::BaseController
  helper :products
  helper :dragonfly
  respond_to :html

  def index
    @search = Supplier.search(params[:search])
    ### @suppliers = Supplier.where("name LIKE ?", "%#{params[:search]}%")
    @suppliers = @search.all
    respond_with(@suppliers)
  end

  def show
    @supplier = Supplier.find_by_slug(params[:id]) || Supplier.find(params[:id])
    @products = Product.find(:all, :conditions => { :supplier_id => @supplier.id , :deleted_at => nil }).paginate(:page => params[:page], :per_page => 12)
    @json = @supplier.to_gmaps4rails
    @message = Message.new
  end
end
