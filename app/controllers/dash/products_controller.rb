class Dash::ProductsController < Dash::BaseController
  def new 
    @product = Product.new
    @options = Taxon.all
  end
  def create
    @product = current_user.supplier.products.build(params[:product])
    Taxon.all.map {|m| @product.taxons.push(Taxon.find_by_id(params[m.name])) if params.member?(m.name) }
    if @product.save
      redirect_to dash_overview_index_path, :notice => "New product created"
    else
      render "new"
    end
  end
end
