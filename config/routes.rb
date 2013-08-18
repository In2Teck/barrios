TorreCentenario::Application.routes.draw do
  resources :runs

  resources :neighborhoods do
    match 'total_stats', :on => :collection
    match 'stats'
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
  end


  match 'hood_select' => 'display#hood_select', :as => :hood_select

  match 'twitter_share' => 'display#twitter_share', :as => :twitter_share

  match 'profile' => 'display#profile', :as => :profile

  match 'hood_detail' => 'display#hood_detail', :as => :hood_detail

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
