class RatingsAndReviewsController < ApplicationController
  def update
    @product = Product.find params[:product][:id]
    @rating = @product.ratings.build(params[:product][:rating])
    @comment = @product.comments.build(params[:product][:comment])
    @comment.user_id = @rating.user_id = current_user.id
    if @comment.save && @rating.save
      @rating.comment_id = @comment.id
      @rating.save
      redirect_to pretty_product_path(@product, :state => @product.supplier.state.abbr, :supplier => @product.supplier.slug), :notice => "Successful Review"
    elsif @comment.save && !@rating.save
      redirect_to pretty_product_path(@product, :state => @product.supplier.state.abbr, :supplier => @product.supplier.slug), :notice => "Successful Comment"
    elsif !@comment.save && @rating.save
      redirect_to pretty_product_path(@product, :state => @product.supplier.state.abbr, :supplier => @product.supplier.slug), :notice => "Successful Rating"
    else
      flash[:error] = @comment.errors.full_messages.to_sentence
      redirect_to :back
    end
  end
end
