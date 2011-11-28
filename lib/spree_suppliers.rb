require 'spree_core'
require 'spree_suppliers_hooks'
require 'gmaps4rails'
require 'dragonfly'
require 'rack-cache'

module SpreeSuppliers
  class Engine < Rails::Engine
    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate 
      Ability.register_ability(AbilityDecorator)
      #### Modify the controllers with changes that are only associated with the Suppliers extension

      # Append the checkout controller
      #
      CheckoutController.class_eval do

        def edit
          @order_products = @order.products
          @suppliers = @order_products.collect{|item| item.supplier_id}.uniq
          @delivery = Delivery.new
        end

        # Updates the order and advances to the next state (when possible.)
        def update
          @order_products = @order.products
          @suppliers = @order_products.collect{|item| item.supplier_id}.uniq
          if @order.update_attributes(object_params)
            if @order.next
              state_callback(:after)
            else
              flash[:error] = I18n.t(:payment_processing_failed)
              respond_with(@order, :location => checkout_state_path(@order.state))
              return
            end

            if @order.state == "payment" 
              @suppliers.each do |s|
                delivery = @order.deliveries.find_or_create_by_supplier_id(s)
                if delivery
                  if !params["shipping_method"].nil?
                    delivery.update_attributes(:pick_up => params["deliveries"][s.to_s], :pickup_id => params["pickups"][s.to_s], :shipping_method_id => params["shipping_method"][s.to_s])
                  else
                    delivery.update_attributes(:pick_up => params["deliveries"][s.to_s], :pickup_id => params["pickups"][s.to_s])
                  end
                end
              end
            end

            if @order.state == "complete" || @order.completed?
              # This is where the SupplierInvoices are generated
              #generate_invoices
              # Back to the normal checkout process
              flash[:notice] = I18n.t(:order_processed_successfully)
              flash[:commerce_tracking] = "nothing special"
              respond_with(@order, :location => completion_route)
            else
              respond_with(@order, :location => checkout_state_path(@order.state))
            end
          else
            respond_with(@order) { |format| format.html { render :edit } }
          end
        end

      end

      # Append the admin orders controller
      #
      Admin::OrdersController.class_eval do
        def show
          load_order
          @fee = "0.86".to_d
          if current_user.has_role?("vendor")
            @invoices = @order.supplier_invoices
            @invoices.select! {|s| s.supplier_id == current_user.supplier.id}
          else
            @invoices = @order.supplier_invoices
          end
          respond_with(@order)
        end

        def index
          params[:search] ||= {}
          params[:search][:completed_at_is_not_null] ||= '1' if Spree::Config[:show_only_complete_orders_by_default]
          @show_only_completed = params[:search][:completed_at_is_not_null].present?
          params[:search][:meta_sort] ||= @show_only_completed ? 'completed_at.desc' : 'created_at.desc'

          @search = Order.metasearch(params[:search])

          if !params[:search][:created_at_greater_than].blank?
            params[:search][:created_at_greater_than] = Time.zone.parse(params[:search][:created_at_greater_than]).beginning_of_day rescue ""
          end

          if !params[:search][:created_at_less_than].blank?
            params[:search][:created_at_less_than] = Time.zone.parse(params[:search][:created_at_less_than]).end_of_day rescue ""
          end

          if @show_only_completed
            params[:search][:completed_at_greater_than] = params[:search].delete(:created_at_greater_than)
            params[:search][:completed_at_less_than] = params[:search].delete(:created_at_less_than)
          end

          @orders = Order.metasearch(params[:search]).paginate(
            :include  => [:user, :shipments, :payments],
            :per_page => Spree::Config[:orders_per_page],
            :page     => params[:page])

            if current_user.has_role?("vendor")
              @orders.select! {|o| o.supplier_invoices.select {|s| s.supplier_id == current_user.supplier.id}.size > 0}
            end
            respond_with(@orders)
        end
      end

      # Append the admin products controller
      #
      Admin::ProductsController.class_eval do
        before_filter :load
        before_filter :load_index, :only => [:index]
        before_filter :edit_before, :only => [:edit]
        def load
          @suppliers = Supplier.find(:all, :order => "name")
          if !Taxon.find_by_name("Products").nil?
            @options = Taxon.all
          end
        end

        def load_index
          if current_user.roles.member?(Role.find_by_name("vendor"))
            @collection.select! {|c| c.supplier_id == current_user.supplier.id}
          end
        end

        #indicate that we want to create a new product
        def new
          @object = Product.new()
          @status = true
        end

        def edit_before 
          @status = false
        end

        def taxon_push object
          object.taxons = []
          Taxon.all.map {|m| object.taxons.push(Taxon.find_by_id(params[m.name])) if params.member?(m.name)}
          return object
        end

        def reset 
          @status = true
        end

        create.before :create_before
        create.fails :reset
        update.before :update_taxons

        def update_taxons
          @object = taxon_push(@object)
        end

        def create_before
          if current_user.has_role?("vendor")
            @object = current_user.supplier.products.build(params[:product])
          else
            @object = Product.new(params[:product])
          end
          @object = taxon_push(@object)
        end

        def publish
          p = Product.find_by_name(params[:id])
          p.available_on = Date.today
          p.save
          redirect_to edit_admin_product_path(p)
        end

        def unpublish 
          p = Product.find_by_name(params[:id])
          p.available_on = nil
          p.save
          redirect_to edit_admin_product_path(p)
        end

      end

      UserSessionsController.class_eval do
        def create
          authenticate_user!

          if user_signed_in?
            if current_user.has_role?("vendor")
              redirect_to admin_orders_path
            else
              respond_to do |format|
                format.html {
                  flash[:notice] = I18n.t("logged_in_succesfully")
                  redirect_back_or_default(products_path)
                }
                format.js {
                  user = resource.record
                  render :json => {:ship_address => user.ship_address, :bill_address => user.bill_address}.to_json
                }
              end
            end
          else
            flash[:error] = I18n.t("devise.failure.invalid")
            render :new
          end
        end
      end


      #### Modify the Models with changes that are only associated with the Suppliers extension

      # Append the product model
      #
      Product.class_eval do
        belongs_to :supplier
        has_one :item
      end

      # Append the order model
      #
      LineItem.class_eval do
        has_many :items
      end

      Image.class_eval do
        attachment_definitions[:attachment][:styles] = {
          :mini => '48x48>', # thumbs under image
          :small => '100x100>', # images on category view
          :product => '240x240>', # full product image
          :large => '600x600>' # light box image
        }
      end

      # Append the order model
      #
      Order.class_eval do
        has_many :supplier_invoices
        has_many :deliveries

        def generate_invoices(order)
          @order = order
          @order_products = @order.line_items
          @suppliers = @order_products.collect{|item| item.product.supplier_id}.uniq
          @invoices = @suppliers.count

          for i in 0..@invoices - 1
            @supplier_products = @order_products.select{|x| x.product.supplier_id == @suppliers[i]}
            @product_count = @supplier_products.count
            invoice = SupplierInvoice.create(:order_id => @order.id, :supplier_id => @suppliers[i], :item_count => @product_count)

            @supplier_products.each do |item|
              invoice.items.create(:product_id => item.product.id, :quantity => item.quantity, :line_item_id => item.id)
            end

            item_total = "0.00".to_d
            invoice.items.each do |i|
              item_total = (i.line_item.variant.price * i.quantity) + item_total
            end
            invoice.update_attributes(:invoice_total => item_total)
            @invoice = invoice
            #SupplierMailer.invoice_email(@invoice).deliver
          end
        end

        def finalize!
          update_attribute(:completed_at, Time.now)
          self.out_of_stock_items = InventoryUnit.assign_opening_inventory(self)
          # lock any optional adjustments (coupon promotions, etc.)
          adjustments.optional.each { |adjustment| adjustment.update_attribute("locked", true) }
          # generate the invoices for each supplier
          generate_invoices(self)
          OrderMailer.confirm_email(self).deliver

          self.state_events.create({
            :previous_state => "cart",
            :next_state     => "complete",
            :name           => "order" ,
            :user_id        => (User.respond_to?(:current) && User.current.try(:id)) || self.user_id
          })
        end

      end

      # Append the state model
      #
      State.class_eval do
        has_many :suppliers
      end

      # Append the user model
      #
      User.class_eval do
        has_one :supplier

        def user_address
          "#{self.bill_address.address1}, #{self.bill_address.city}, #{self.bill_address.state.country.name}"
        end

        def vendor? 
          self.roles.member?(Role.find_by_name("vendor"))
        end
      end

      ###      UGLY HACK 
      Admin::ProductsController.class_eval do
        def authorize_admin
          authorize! :admin, Product
          authorize! params[:action].to_sym, Product
        end
      end

      Admin::PromotionsController.class_eval do
        def authorize_admin
          authorize! :admin, Promotion
          authorize! params[:action].to_sym, Promotion
        end
      end

      Admin::VariantsController.class_eval do
        def authorize_admin
          authorize! :admin, Variant
          authorize! params[:action].to_sym, Variant
        end
      end

      Admin::OptionTypesController.class_eval do
        def authorize_admin 
          authorize! :admin, OptionType
          authorize! params[:action].to_sym, OptionType
        end
      end

      Admin::PropertiesController.class_eval do
        def authorize_admin 
          authorize! :admin , Property
          authorize! params[:action].to_sym, Property
        end
      end

      Admin::PrototypesController.class_eval do
        def authorize_admin 
          authorize! :admin, Prototype
          authorize! params[:action].to_sym, Prototype
        end
      end

      Admin::ProductGroupsController.class_eval do
        def authorize_admin 
          authorize! :admin, ProductGroup
          authorize! params[:action].to_sym, ProductGroup
        end
      end

      Admin::ProductPropertiesController.class_eval do
        def authorize_admin 
          authorize! :admin, Product
          authorize! params[:action].to_sym, Product
        end
      end

      Admin::TaxonsController.class_eval do
        def authorize_admin 
          authorize! :admin, Taxon
          authorize! params[:action].to_sym, Taxon
        end
      end

      Admin::PickupsController.class_eval do
        def authorize_admin 
          authorize! :admin, Pickup
          authorize! params[:action].to_sym, Pickup
        end
      end

      Admin::PickupLocationsController.class_eval do
        def authorize_admin 
          authorize! :admin, PickupLocation
          authorize! params[:action].to_sym, PickupLocation
        end
      end

      Admin::OrdersController.class_eval do
        def authorize_admin
          authorize! :admin, Order
          authorize! params[:action].to_sym, Order
        end
      end


      Admin::SuppliersController.class_eval do
        def authorize_admin
          authorize! :admin, Supplier
          authorize! params[:action].to_sym, Supplier
        end
      end

      ###      END UGLY HACK
    end

    config.to_prepare &method(:activate).to_proc
  end
end
