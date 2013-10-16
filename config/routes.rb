TorreCentenario::Application.routes.draw do
  resources :runs

  resources :neighborhoods do
    match 'total_stats', :on => :collection
    match 'stats'
    match 'add_kilometers'
  end

  resources :roles

  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks"}

  devise_scope :user do
    #TODO: PROTECT SIGNIN AND SIGNUP DIRECT LINKS
	  get 'logout', :to => "devise/sessions#destroy"
	  #get 'signin', :to => "devise/sessions#new"
	  #get 'signup', :to => "devise/registrations#new"
  end

  resources :users do
    match 'update_runs', :on => :collection
    match 'update_hood', :on => :collection
    match 'create_user_externally', :on => :collection
    match 'add_kilometers_externally', :on => :collection
  end

  match 'imprimir_invitacion' => 'display#print_screen', :as => :print_screen

  match 'registro_datos' => 'display#register_muertos', :as => :register_muertos

  match 'selecciona_barrio' => 'display#hood_select', :as => :hood_select
  
  match 'reselecciona_barrio' => 'display#hood_reselect', :as => :hood_reselect

  match 'confirma_asistencia' => 'display#confirm_attendance', :as => :confirm_attendance

  match 'reto-dia-de-muertos' => 'display#race_invite', :as => :race_invite

  match 'ingresa_twitter' => 'display#twitter_share', :as => :twitter_share

  match 'perfil' => 'display#profile', :as => :profile

  match 'barrio/:id' => 'display#hood_detail', :as => :hood_detail
  
  match 'comparte_carreras' => 'display#coming_soon', :as => :coming_soon

  match 'ranking' => 'display#hood_ranking', :as => :hood_ranking
  
  match 'terminos' => 'display#terms_and_conditions', :as => :terms_and_conditions

  match 'redirect' => 'display#redirect', :as => :redirect
  
  match 'admin' => 'display#admin', :as => :admin
  
  match 'csv' => 'display#csv', :as => :csv
  
  match 'csv_all_users' => 'display#csv_all_users', :as => :csv_all_users

  match 'registrados' => 'display#print_attendees', :as => :print_attendees

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'display#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
