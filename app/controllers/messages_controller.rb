class MessagesController < ApplicationController

  def create
    @message = Message.new(params[:message])
    if @message.save
      flash[:notice] = "Message sent"
      redirect_to :back
    else
      flash[:error] = @message.errors
      redirect_to :back
    end
  end

  def destroy
  end

end
