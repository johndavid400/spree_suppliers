class Spree::Admin::SupplierTaxonsController < Spree::Admin::BaseController
#  include Railslove::Plugins::FindByParam::SingletonMethods
#  helper "spree/admin/taxons"

  respond_to :html, :json, :js

  def selected
    @supplier = load_supplier
    @taxons = @supplier.taxons
    @options = Spree::Taxon.all
    respond_with(:admin, @taxons)
  end

  def available
    @supplier = load_supplier
    @taxons = params[:q].blank? ? [] : Spree::Taxon.where('lower(name) LIKE ?', "%#{params[:q].mb_chars.downcase}%")
    @taxons.delete_if { |taxon| @supplier.taxons.include?(taxon) }
    respond_with(:admin, @taxons)
  end

  def remove
    @supplier = load_supplier
    @taxon = Spree::Taxon.find(params[:id])
    @supplier.taxons.delete(@taxon)
    @supplier.save
    @taxons = @supplier.taxons
    respond_with(@taxon) { |format| format.js { render_js_for_destroy } }
  end

  def select
    @supplier = load_supplier
    @taxon = Spree::Taxon.find(params[:id])
    @supplier.taxons << @taxon
    @supplier.save
    @taxons = @supplier.taxons
    respond_with(:admin, @taxons)
  end

  def batch_select
    @supplier = load_supplier
    @taxons = params[:taxon_ids].map{|id| Spree::Taxon.find(id)}.compact
    @supplier.taxons = @taxons
    @supplier.save
    redirect_to selected_admin_supplier_taxons_url(@supplier)
  end

  def update_taxons
    @supplier = Spree::Supplier.find params[:supplier_id]
    @supplier.taxons = []
    @supplier.taxons.push(Spree::Taxon.all.select{|t| params[t.name.to_s] })
    @supplier.save
    redirect_to :back, :notice => "Taxons successfully added"
  end

  private

  def load_supplier
    Spree::Supplier.find params[:supplier_id]
  end

end
