class Admin::SupplierTaxonsController < Admin::BaseController
  include Railslove::Plugins::FindByParam::SingletonMethods
  helper "admin/taxons"

  respond_to :html, :json, :js

  def selected
    @supplier = load_supplier
    @taxons = @supplier.taxons
    @options = Taxon.all
    respond_with(:admin, @taxons)
  end

  def available
    @supplier = load_supplier
    @taxons = params[:q].blank? ? [] : Taxon.where('lower(name) LIKE ?', "%#{params[:q].mb_chars.downcase}%")
    @taxons.delete_if { |taxon| @supplier.taxons.include?(taxon) }
    respond_with(:admin, @taxons)
  end

  def remove
    @supplier = load_supplier
    @taxon = Taxon.find(params[:id])
    @supplier.taxons.delete(@taxon)
    @supplier.save
    @taxons = @supplier.taxons
    respond_with(@taxon) { |format| format.js { render_js_for_destroy } }
  end

  def select
    @supplier = load_supplier
    @taxon = Taxon.find(params[:id])
    @supplier.taxons << @taxon
    @supplier.save
    @taxons = @supplier.taxons
    respond_with(:admin, @taxons)
  end

  def batch_select
    @supplier = load_supplier
    @taxons = params[:taxon_ids].map{|id| Taxon.find(id)}.compact
    @supplier.taxons = @taxons
    @supplier.save
    redirect_to selected_admin_supplier_taxons_url(@supplier)
  end

  def update_taxons
    @supplier = Supplier.find params[:supplier_id]
    @supplier.taxons = []
    @supplier.taxons.push(Taxon.all.select{|t| params[t.name.to_s] })
    @supplier.save
    redirect_to :back, :notice => "Taxons successfully added"
  end

  private

  def load_supplier
    Supplier.find params[:supplier_id]
  end

end
