class Dash::BaseController < Spree::BaseController
  
  before_filter :authenticate_user!, :vendor_role
  def vendor_role
    if !current_user.roles.member?(Role.find_by_name("vendor"))
      flash[:error] = "You are not a vendor"
      redirect_to root_path
    end
  end
end
