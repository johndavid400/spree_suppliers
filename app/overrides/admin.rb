Deface::Override.new(:virtual_path => "layouts/admin",
                     :name => "suppliers_tabs",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<%= tab(:suppliers) %>",
                     :disabled => false)
