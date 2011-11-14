class Dash::OverviewController < Dash::BaseController
  def index 
    @user = User.find(current_user.id) 
    @invoices = @user.supplier.supplier_invoices
  end
end
