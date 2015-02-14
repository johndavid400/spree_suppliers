class Spree::Admin::VendorOverviewController < Spree::BaseController
  ssl_required

  layout 'admin'

  before_filter :vendor

  def vendor
    if !spree_user.has_spree_role?("vendor")
      unauthorized
    end
  end
  def index

  end
end
