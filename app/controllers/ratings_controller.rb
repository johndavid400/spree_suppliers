class RatingsController < Spree::BaseController
  before_filter :authenticate_user!

  def create
    @product = Product.find_by_id(params[:product_id])
    @rating = Rating.new(params[:rating])
    @rating.product_id = @product.id
    @rating.user_id = current_user.id

    if @rating.save
      flash[:notice] = "Your rating has been saved"
    else
      flash[:error] = "There was a problem saving your rating"
    end
    redirect_to pretty_product_path(@product, :state => @product.supplier.state.abbr, :supplier => @product.supplier.slug)
  end

  def update
    @product = Product.find_by_id(params[:product_id])
    # FIXME: Make it so that you cannot rate your own products
    @rating = current_user.ratings.find_by_product_id(@product.id)
    if @rating.update_attributes(params[:rating])
      respond_to do |format|
        format.html { redirect_to pretty_product_path(@product, :state => @product.supplier.state.abbr, :supplier => @product.supplier.slug), :notice => "Your rating has been updated" }
      end
    end
  end
end