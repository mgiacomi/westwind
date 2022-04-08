Rails.application.routes.draw do

  match '/home'          => 'logins#home',          :as => :home,      :via => :get
  match '/logout'        => 'logins#logout',        :as => :logout,    :via => :post
  match '/login/:id'     => 'logins#login',         :as => :login,     :via => :get
  match '/support'       => 'logins#support',       :as => :support,   :via => :get
  match '/privacy'       => 'logins#privacy',       :as => :privacy,   :via => :get
  match '/denied'        => 'logins#denied',        :as => :denied,    :via => :get
  match '/forgot/screen' => 'logins#forgot_screen', :as => :forgot_s,  :via => :get
  match '/forgot/email'  => 'logins#forgot_email',  :as => :forgot_e,  :via => :post

  match '/vaccines'        => 'vaccines#index',     :as => :vaccines_index,     :via => :get
  match '/vaccines/submit' => 'vaccines#submit',    :as => :vaccines_submit,    :via => :post

  match '/waivers'             => 'waivers#index',     :as => :waivers_index,   :via => :get
  match '/waivers/sign/:id'    => 'waivers#sign',      :as => :waivers_sign,    :via => :get
  match '/waivers/submit/:id'  => 'waivers#submit',    :as => :waivers_submit,  :via => :post
  match '/waivers/email/:id'   => 'waivers#email',     :as => :waivers_email,   :via => :get
  match '/waivers/remote/:id'  => 'waivers#remote',    :as => :waivers_remote,  :via => :get
  match '/waivers/rsubmit/:id' => 'waivers#rsubmit',   :as => :waivers_rsubmit, :via => :post
  match '/waivers/thanks/:id'  => 'waivers#thanks',    :as => :waivers_thanks,  :via => :get

  match '/profile'            => 'profiles#index',     :as => :profile_index,     :via => :get
  match '/campers'            => 'profiles#campers',   :as => :profile_campers,   :via => :get
  match '/campers/toggle'     => 'profiles#toggle',    :as => :profile_toggle,    :via => :post
  match '/campers/allergies'  => 'profiles#allergies', :as => :profile_allergies, :via => :post

  match '/payments' => 'payments#index',       :as => :payments_index,     :via => :get
  match '/receipt'  => 'payments#receipt',     :as => :payments_receipt,   :via => :post
  match '/onk'      => 'payments#onk_receipt', :as => :onk_receipt,        :via => :post

  devise_for :users, skip: :registrations

  # Admin Resources
  #namespace :wmgr do
  #  resources :members
  #end

  match '/wmgr'                => 'wmgr/overviews#index',         :as => :wmgr_overviews,      :via => :get
  match '/wmgr/search'         => 'wmgr/overviews#search',        :as => :wmgr_search,         :via => :post
  match '/wmgr/weeks'          => 'wmgr/weeks#index',             :as => :wmgr_weeks_index,    :via => :get
  match '/wmgr/weeks/:id'      => 'wmgr/weeks#index',             :as => :wmgr_weeks,          :via => :get
  match '/wmgr/family/:id'     => 'wmgr/families#show',           :as => :wmgr_family,         :via => :get
  match '/wmgr/family/onk/:id' => 'wmgr/families#onk',            :as => :wmgr_onk,            :via => :post
  match '/wmgr/payment/:id'    => 'wmgr/families#payment',        :as => :wmgr_payment,        :via => [:post,:put]
  match '/wmgr/week/:id'       => 'wmgr/families#week',           :as => :wmgr_week,           :via => [:post,:put,:patch]
  match '/wmgr/payment/:id'    => 'wmgr/families#payment_delete', :as => :wmgr_payment_delete, :via => :delete
  match '/wmgr/person/new/:id' => 'wmgr/members#new',             :as => :wmgr_person_new,     :via => :get
  match '/wmgr/person'         => 'wmgr/members#create',          :as => :wmgr_person_create,  :via => :post
  match '/wmgr/person/:id'     => 'wmgr/members#edit',            :as => :wmgr_person_edit,    :via => :get
  match '/wmgr/person/:id'     => 'wmgr/members#update',          :as => :wmgr_person_update,  :via => [:put,:patch]
  match '/wmgr/person/:id'     => 'wmgr/members#delete',          :as => :wmgr_person_delete,  :via => :delete

  match '/wmgr/onkmember/complete/:week'   => 'wmgr/overviews#onkmember_complete',   :as => :wmgr_onk_complete,       :via => :get
  match '/wmgr/onkmember/incomplete/:week' => 'wmgr/overviews#onkmember_incomplete', :as => :wmgr_onk_incomplete,     :via => :get
  match '/wmgr/deposit/paid/:week'         => 'wmgr/overviews#deposit_paid',         :as => :wmgr_deposit_paid,       :via => :get
  match '/wmgr/deposit/unpaid/:week'       => 'wmgr/overviews#deposit_unpaid',       :as => :wmgr_deposit_unpaid,     :via => :get
  match '/wmgr/fullpayment/paid/:week'     => 'wmgr/overviews#fullpayment_paid',     :as => :wmgr_fullpayment_paid,   :via => :get
  match '/wmgr/fullpayment/unpaid/:week'   => 'wmgr/overviews#fullpayment_unpaid',   :as => :wmgr_fullpayment_unpaid, :via => :get
  match '/wmgr/dietary/complete/:week'     => 'wmgr/overviews#dietary_complete',     :as => :wmgr_dietary_complete,   :via => :get
  match '/wmgr/dietary/incomplete/:week'   => 'wmgr/overviews#dietary_incomplete',   :as => :wmgr_dietary_incomplete, :via => :get
  match '/wmgr/waivers/complete/:week'     => 'wmgr/overviews#waivers_complete',     :as => :wmgr_waivers_complete,   :via => :get
  match '/wmgr/waivers/incomplete/:week'   => 'wmgr/overviews#waivers_incomplete',   :as => :wmgr_waivers_incomplete, :via => :get
  match '/wmgr/volunteers/:week'           => 'wmgr/overviews#volunteers',           :as => :wmgr_volunteers,         :via => :get
  match '/wmgr/attendance:week.:format'    => 'wmgr/overviews#attendance',           :as => :wmgr_attendance,         :via => :get
  match '/wmgr/dietary_week:week.:format'  => 'wmgr/overviews#dietary',              :as => :wmgr_dietary,            :via => :get

  match '/wmgr/report/families.:format' => 'wmgr/overviews#families', :as => :wmgr_report_families, :via => :get
  match '/wmgr/report/people.:format'   => 'wmgr/overviews#people',   :as => :wmgr_report_people,   :via => :get

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
