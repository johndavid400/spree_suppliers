STATE_CONSTRAINTS = /AL/i

Rails.application.routes.draw do
  resources :suppliers
  resources :cities
  resources :messages
  resources :deliveries
  resources :ratings_and_reviews
  resources :ratings
  
  match '/:state/:supplier/:id', :controller => 'products', :action => 'show', :constraints => { :state => STATE_CONSTRAINTS }, :as => :pretty_product
    
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
    match "upload_image" => "suppliers#upload_image"
    match "destroy_image" => "suppliers#destroy_image"
    match "make_logo" => "suppliers#make_logo"
    match "feature_image" => "suppliers#feature_image"

    resources :overview
    resources :pickups
    resources :pickup_locations
    resources :shipping_options

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

    resources :vendor_overview
  end
end
