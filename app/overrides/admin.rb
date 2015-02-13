Deface::Override.new(:virtual_path => "spree/admin/shared/tabs",
                     :name => "suppliers_tabs",
                     :insert_after => ".*",
                     :text => "<% if can?(:admin, Spree::Supplier) %><%= tab :suppliers, icon: 'user' %><% end %>",
                     :disabled => false)
