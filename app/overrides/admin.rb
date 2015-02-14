Deface::Override.new(:virtual_path => "spree/admin/shared/_tabs",
                     :name => "suppliers_tab",
                     :insert_after => "erb[silent]:last-child",
                     :text => "<% if can?(:admin, Suppliers) %><%= tab [:suppliers], icon: 'user' %><% end %>",
                     :disabled => false)
