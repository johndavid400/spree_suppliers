UserSessionsController.class_eval do

  layout "sign_in"

  # SSL is required in the Gem for new, create, update, and destroy

  def destroy
    session.clear
    super
    # added flash notice when users log out
    flash[:notice] = I18n.t("logged_out")
  end

  def create
    authenticate_user!
    if user_signed_in?
      respond_to do |format|
        format.html {
          flash[:notice] = I18n.t("logged_in_succesfully")
          if current_user.has_role?("vendor")
            redirect_to admin_vendor_overview_index_path
          elsif current_user.has_role?("admin")
            redirect_to admin_overview_index_path
          else
            redirect_back_or_default(root_path)
          end
        }
        format.js {
          user = resource.record
          render :json => {:ship_address => user.ship_address, :bill_address => user.bill_address}.to_json
        }
      end
    else
      flash[:error] = I18n.t("devise.failure.invalid")
      render :new
    end
  end

end
