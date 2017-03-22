Rails.application.routes.draw do

  match '/home'          => 'logins#home',          :as => :home,      :via => :get
  match '/logout'        => 'logins#logout',        :as => :logout,    :via => :post
  match '/login/:id'     => 'logins#login',         :as => :login,     :via => :get
  match '/support'       => 'logins#support',       :as => :support,   :via => :get
  match '/privacy'       => 'logins#privacy',       :as => :privacy,   :via => :get
  match '/denied'        => 'logins#denied',        :as => :denied,    :via => :get
  match '/forgot/screen' => 'logins#forgot_screen', :as => :forgot_s,  :via => :get
  match '/forgot/email'  => 'logins#forgot_email',  :as => :forgot_e,  :via => :post

  match '/profile'            => 'profiles#index',     :as => :profile_index,     :via => :get
  match '/campers'            => 'profiles#campers',   :as => :profile_campers,   :via => :get
  match '/campers/toggle'     => 'profiles#toggle',    :as => :profile_toggle,    :via => :post
  match '/campers/allergies'  => 'profiles#allergies', :as => :profile_allergies, :via => :post

  match '/payments' => 'payments#index',       :as => :payments_index,     :via => :get
  match '/receipt'  => 'payments#receipt',     :as => :payments_receipt,   :via => :post
  match '/onk'      => 'payments#onk_receipt', :as => :onk_receipt,        :via => :post

  devise_for :users, skip: :registrations

  # Admin Resources
  #namespace :rmgr do
  #  resources :teachers, :students
  #end

  match '/wmgr'                  => 'wmgr/overviews#index',        :as => :wmgr_overviews,     :via => :get
  match '/wmgr/pledge/email/:id' => 'wmgr/overviews#pledge_email', :as => :wmgr_pledge_email,  :via => :get

  root 'logins#home'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
end
