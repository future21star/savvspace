Rails.application.routes.draw do
  resources :property_searches
  get 'ivr/click_to_call', format: :xml

  get 'idx/', to: "idx#index"

  resources :subscriptions, only: [:index]

  devise_for :users

  resources :phone_calls
  resources :services

  resources :vendors do
    resource :profile
    resources :services
  end

  resources :articles
  resources :article_categories do
    resources :articles, only: :index
  end
  resources :ambassadorships
  resources :areas
  resources :profiles
  get '/profiles/:id/:tab', to: "profiles#show", as: :profile_tab
  get '/u/:username', to: "profiles#show", as: :public_profile
  resources :ratings
  resources :authors, only: [:index] do
    resources :articles, only: [:index]
  end
  resources :users do
    resource :profile
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'subscriptions#index'
  get '/dashboard' => 'welcome#dashboard', as: :dashboard
  get '/home' => 'welcome#index', as: :home
  get '/about' => 'welcome#about', as: :about
  get '/contact' => 'welcome#contact', as: :contact

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  mount Attachinary::Engine => "/attachinary"
end
