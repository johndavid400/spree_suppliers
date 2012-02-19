Spree::Core::Engine.routes.append do
  # Add your extension routes here
  resources :suppliers
  resources :supplier_invoices
  resources :invoice_items

  namespace :admin do

    resources :suppliers do
      get 'feature'
      resources :taxons, :controller => "supplier_taxons" do
        member do
          get :select
          delete :remove
        end
        collection do
          post :available
          post :batch_select
          get  :selected
          post :update_taxons
        end
      end
    end

    resources :products do
      resources :suppliers, :member => {:select => :post, :remove => :post}, :collection => {:available => :post, :selected => :get}
      member do
        get :publish
        get :unpublish
      end
    end
    resources :orders do
      resources :suppliers, :collection => {:line_items => :get}
    end

  end
end
