class SpreeSuppliersHooks < Spree::ThemeSupport::HookListener
  insert_below :admin_tabs do
    %(<%= tab(:suppliers) %>)
  end

  insert_after :admin_configuration_menu do
    %(<tr><td><%= link_to t("Suppliers"), admin_suppliers_url %><td><td><%= t("Suppliers_description") %></td></tr>)
  end

  # Add on_hand field to admin/products listing
  insert_after :admin_products_index_headers do
    %(<th><%= sort_link @search, :count_on_hand, t("count_on_hand") %></th>)
  end

  insert_after :admin_products_index_rows do
    %(<td><%= product.count_on_hand %></td>)
  end

end
