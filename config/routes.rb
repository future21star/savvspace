Rails.application.routes.draw do
  resources :messages
  post 'stripe/create_customer'

  resources :property_notes
  resources :favorite_items

  resources :favorites, only: :index

  resources :open_houses do
    resources :open_house_mailers, only: [:new, :create]
  end
  resources :open_house_searches

  resources :features do
    resources :feature_requests, shallow: true
  end

  resources :property_searches
  get 'ivr/click_to_call', format: :xml
  
  resources :subscriptions, only: [:index]

  devise_for :users

  post 'users/:user_id/authorizations/:role_name', to: 'authorizations#create', as: :create_authorization
  delete 'users/:user_id/authorizations/:role_name', to: 'authorizations#destroy', as: :delete_authorization

  resources :phone_calls
  resources :services

  resources :vendors do
    resource :profile
    resources :services
  end

  resources :mls_servers do
    resources :properties
  end

  resources :properties do
    resources :property_notes
    resources :property_mailers, only: [:new, :create]
  end

  resources :favorites_mailers, only: [:new, :create]

  resources :articles
  resources :article_categories do
    resources :articles, only: :index
  end
  resources :ambassadorships
  resources :areas
  resources :profiles do
    resources :conversations
  end
  resources :conversations do
    resources :messages
  end
  get '/profiles/:id/:tab', to: 'profiles#show', as: :profile_tab
  get '/u/:username', to: 'profiles#show', as: :public_profile
  resources :ratings
  resources :trailblazers, only: [:index] do
    resources :articles, only: [:index]
  end
  resources :users do
    resource :profile
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with 'rake routes'.

  # You can have the root of your site routed with 'root'
  root 'subscriptions#index'
  get '/dashboard' => 'welcome#dashboard', as: :dashboard
  get '/home' => 'welcome#index', as: :home
  get '/about' => 'welcome#about', as: :about
  get '/contact' => 'welcome#contact', as: :contact

  get '/help' => 'help#show', as: :help
  get '/faqs' => 'f_a_qs#index', as: :faqs
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

  mount Attachinary::Engine => '/attachinary'
end
