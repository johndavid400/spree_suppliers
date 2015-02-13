Deface::Override.new(:virtual_path => "spree/admin/shared/_tabs",
                     :name => "suppliers_tabs",
                     :insert_after => "erb[silent]:last-child",
                     :text => "<% if can?(:admin, Spree::Supplier) %><%= tab :suppliers, icon: 'user' %><% end %>",
                     :disabled => false)
