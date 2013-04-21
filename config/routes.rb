SGfM::Application.routes.draw do

  scope '/:locale' do

    # Devise routes
    devise_for :logins, :controllers => {:registrations => 'registrations'}, :path => '', :path_names => {:sign_up => 'signup',
                                                                                                          :sign_in => 'login',
                                                                                                          :sign_out => 'logout',
                                                                                                          :confirmations => 'confirmations'}

    get   'logins/show' => 'logins#show'


    # Actor routes
    get   'actors'          => 'actor#list',    as: 'actors'
    get   'actors/create'   => 'actor#new',     as: 'create_actor'
    post  'actors/create'   => 'actor#create'
    get   'actors/:id'      => 'actor#show',    as: 'show_actor'
    get   'actors/edit/:id' => 'actor#edit',    as: 'edit_actor'
    post  'actors/edit/:id' => 'actor#update',  as: 'update_actor'

    # Relationship routes
    get     'relationship/create/:actor'  => 'relationship#new',      as: 'create_relationship'
    post    'relationship/create/:actor'  => 'relationship#create'
    get     'relationship/edit/:id'       => 'relationship#edit',     as: 'edit_relationship'
    post    'relationship/edit/:id'       => 'relationship#update',   as: 'update_relationship'
    delete  'relationship/destroy/:id'    => 'relationship#destroy',  as: 'delete_relationship'

    # InformationType routes
    get   'information_types'           => 'information_type#list',   as: 'information_types'
    get   'information_types/create'    => 'information_type#new',    as: 'create_information_type'
    post  'information_types/create'    => 'information_type#create'
    get   'information_types/:id'       => 'information_type#show',   as: 'show_information_type'
    get   'information_types/edit/:id'  => 'information_type#edit',   as: 'edit_information_type'
    post  'information_types/edit/:id'  => 'information_type#update', as: 'update_information_type'

    # ActorType routes
    get   'actor_types'           => 'actor_type#list',   as: 'actor_types'
    get   'actor_types/create'    => 'actor_type#new',    as: 'create_actor_type'
    post  'actor_types/create'    => 'actor_type#create'
    get   'actor_types/:id'       => 'actor_type#show',   as: 'show_actor_type'
    get   'actor_types/edit/:id'  => 'actor_type#edit',   as: 'edit_actor_type'
    post  'actor_types/edit/:id'  => 'actor_type#update', as: 'update_actor_type'

    # RelationshipType routes
    get     'relationship_types'              => 'relationship_type#list',      as: 'relationship_types'
    get     'relationship_types/create'       => 'relationship_type#new',       as: 'create_relationship_type'
    post    'relationship_types/create'       => 'relationship_type#create'
    get     'relationship_types/:id'          => 'relationship_type#show',      as: 'show_relationship_type'
    get     'relationship_types/edit/:id'     => 'relationship_type#edit',      as: 'edit_relationship_type'
    post    'relationship_types/edit/:id'     => 'relationship_type#update',    as: 'update_relationship_type'
    delete  'relationship_types/destroy/:id'  => 'relationship_type#destroy',  as: 'delete_relationship_type'


		#Scopes Routes
		get 'scopes' => 'scopes#list', as: 'scopes'
		get 'scopes/create' => 'scopes#new', as: 'create_scope'
		post 'scopes/create' => 'scopes#create'
		get 'scopes/edit/:id' => 'scopes#edit', as: 'edit_scope'
		post 'scopes/edit/:id' => 'scopes#update'
		delete 'scopes/destroy/:id' => 'scopes#destroy', as: 'delete_scope'


    # Search routes
    get   'search'          => 'search#list',    as: 'search'
    get   'search_actor/:id'=> 'search#show',    as: 'search_actor'
    post 'search' => 'search#list'


    # Development routes
    get   'all/reset' => 'application#reset_all', as: 'reset_all'

    # CSV Import routes
    get     'csv_import/file/new'     => 'csv_import#new_csv_file',     as: 'new_csv_file'
    post    'csv_import/file/upload'  => 'csv_import#upload_csv_file',  as: 'upload_csv_file'
    get     'csv_import/file/list'    => 'csv_import#list_csv_files',   as: 'list_csv_files'
    delete  'csv_import/file/:id'     => 'csv_import#delete_csv_file',  as: 'delete_csv_file'
    put    'csv_import/import/execute/:id'   => 'csv_import#import',  as: 'import_csv_file'
    get     'csv_import/import/new/:id'   => 'csv_import#new_import',  as: 'new_import'
    get     'csv_import/import/add_row/:id'   => 'csv_import#add_row',  as: 'add_row'

    # AJAX routes
    get   '/information_types_for_actor_type' => 'actor#information_types_for_actor_type', as: 'information_types_for_actor_type'
    get   '/add_relationship_form'            => 'ajax#add_relationship_form',             as: 'add_relationship_form'
    get   '/add_information_type_form'        => 'ajax#add_information_type_form',         as: 'add_information_type_form'
    get   '/information_type_data_form'       => 'ajax#information_type_data_form',        as: 'information_type_data_form'
    get   '/information_type_option_form'     => 'ajax#information_type_option_form',      as: 'information_type_option_form'
    # Root
    root :to => 'home#index', as: 'home'

  end

  # Needed to route '/' without locale
  match '/' => 'home#index'

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
