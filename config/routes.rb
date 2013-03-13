SGfM::Application.routes.draw do


  devise_for :logins, :controllers => {:registrations => 'registrations'}, :path => '', :path_names => {:sign_up => 'signup',
                                                                                                        :sign_in => 'login',
                                                                                                        :sign_out => 'logout'}
  root :to => 'home#index', as: 'home'

  get 'logins/show' => 'logins#show'


  get 'actors' => 'actor#list', as: 'actors'

  get 'actors/create' => 'actor#new', as: 'create_actor'
  post 'actors/create' => 'actor#create'

  get 'actors/:id' => 'actor#show', as: 'show_actor'

  get 'actortype/reset' => 'actor_type#reset_default_types', as: 'reset_actortype'
  get 'actor/reset' => 'actor#reset_default_types', as: 'reset_actor'
  get 'information/reset' => 'information#reset_default_types', as: 'reset_information'
  get 'informationtype/reset' => 'information_type#reset_default_types', as: 'reset_informationtype'
  get 'types/reset' => 'application#reset_default_types', as: 'reset_types'

  match "/information_types_for_actor_type" => "actor#information_types_for_actor_type"

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
