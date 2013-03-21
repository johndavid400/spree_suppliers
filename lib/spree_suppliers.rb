require 'spree_core'
require 'spree_suppliers/engine'

module SpreeSuppliers
  class Engine < Rails::Engine
    config.autoload_paths += %W(#{config.root}/lib)
    def self.activate

      Spree::User.class_eval do
        def has_role?(role)
          self.spree_roles.include?(Spree::Role.find_by_name(role))
        end
      end

      Spree::LineItem.class_eval do
        has_many :invoice_items
      end

      Spree::Image.class_eval do
        belongs_to :supplier
      end

      Spree::Admin::OrdersController.class_eval do
        def show
          load_order
          # optional fee that admin can charge to sell suppliers products for them
          @fee = 0.10
          if current_user.has_role?(Spree::Role.find_by_name("vendor"))
            @invoices = @order.supplier_invoices
            @invoices.select! {|s| s.supplier_id == current_user.supplier.id}
          else
            @invoices = @order.supplier_invoices
          end
          respond_with(@order)
        end

      end

      Spree::Order.class_eval do
        has_many :supplier_invoices
        def generate_invoices(order)
          @order = order
          @order_products = @order.line_items
          @suppliers = @order_products.collect{|item| item.product.supplier_id}.uniq
          @invoices = @suppliers.count

          for i in 0..@invoices - 1
            @supplier_products = @order_products.select{|x| x.product.supplier_id == @suppliers[i]}
            @product_count = @supplier_products.count
            invoice = Spree::SupplierInvoice.create(:order_id => @order.id, :supplier_id => @suppliers[i], :item_count => @product_count)

            @supplier_products.each do |item|
              invoice.invoice_items.create(:product_id => item.product.id, :quantity => item.quantity, :line_item_id => item.id)
            end

            item_total = "0.00".to_d
            invoice.invoice_items.each do |i|
              item_total = (i.line_item.variant.price * i.quantity) + item_total
            end
            invoice.update_attributes(:invoice_total => item_total)
            @invoice = invoice
            #SupplierMailer.invoice_email(@invoice).deliver
          end
        end

        def finalize!
          update_attribute(:completed_at, Time.now)
          Spree::InventoryUnit.assign_opening_inventory(self)
          # lock any optional adjustments (coupon promotions, etc.)
          adjustments.optional.each { |adjustment| adjustment.update_attribute('locked', true) }
          # generate the invoices for each supplier
          generate_invoices(self)
          #OrderMailer.confirm_email(self).deliver

          self.state_events.create({
            :previous_state => 'cart',
            :next_state => 'complete',
            :name => 'order' ,
            :user_id => (User.respond_to?(:current) && User.current.try(:id)) || self.user_id
          })
        end
      end


      Spree::Admin::ProductsController.class_eval do
        before_filter :load
        before_filter :load_index, :only => [:index]
        before_filter :edit_before, :only => [:edit]
        create.before :create_before

        def load
          @suppliers = Spree::Supplier.find(:all, :order => "name")
          @options = Spree::Taxon.all
        end

        def load_index
          if current_user.has_role?(Spree::Role.find_by_name("vendor"))
            @collection.select! {|c| c.supplier_id == current_user.supplier.id}
          end
        end

        #indicate that we want to create a new product
        def new
          @object = Spree::Product.new()
          @status = true
          @suppliers = Spree::Supplier.all
        end

        def edit_before
          @suppliers = Spree::Supplier.all
          @status = false
        end

        def update_taxons
          @object = taxon_push(@object)
        end

        def create_before
          if current_user.has_role?(Spree::Role.find_by_name("vendor"))
            @object = current_user.supplier.products.build(params[:product])
          else
            @object = Spree::Product.new(params[:product])
          end
          @object = taxon_push(@object)
        end

        def publish
          p = Spree::Product.find_by_name(params[:id])
          p.available_on = Date.today
          p.save
          redirect_to edit_admin_product_path(p)
        end

        def unpublish
          p = Spree::Product.find_by_name(params[:id])
          p.available_on = nil
          p.save
          redirect_to edit_admin_product_path(p)
        end
      end

      Spree::Product.class_eval do
        belongs_to :supplier
      end

      Spree::Taxon.class_eval do
        has_and_belongs_to_many :suppliers
      end

      Spree::User.class_eval do
        has_one :supplier
      end

    end
    config.to_prepare &method(:activate).to_proc
  end
end

