DevList::Application.routes.draw do

  root :to => "dashboard#index"

  match '/auth/:provider/callback', :to => 'external_auth#create'
  match '/auth/failure', :to => 'external_auth#fail'
  get '/verify/:provider', :to => 'external_auth#new'

  devise_for :user, 
    :path => 'user', 
    :path_names => { 
      :sign_in => "login", 
      :sign_out => "logout", 
      :sign_up => "register",
      :password => "forgotten_password",
      :confirmation => "email_confirmation",
      :unlock => "unlock_account"
    }

  resources :messages, :controller => "message_chains", only: [:index, :show, :create] do
    member do 
      get :read
    end
  end

  resource :user_photo, :controller => "user_photo", only: [:create, :destroy], :path => "/user/photo"

  resources :project_images, only: [:create, :destroy], :path => "/project/images"

  resource :profile, :controller => "user_profiles", only: [:edit, :update] do
    resources :verified_contacts, only: [:destroy]
  end
  
  resources :users, :path => "", :controller => "user_profiles", :constraints => { :user_id => /[a-zA-Z0-9_]{5,}/ }, only: [] do
    resources :projects, :controller => "user_projects", except: [:index] do
      member do
        get 'follow'
        get 'unfollow'
      end
    end
  end

  resources :users, :path => "", :controller => "user_profiles", :constraints => { :id => /[a-zA-Z0-9_]{5,}/ }, only: [:show] do
    member do
      get 'follow'
      get 'unfollow'
      get 'followers'
      get 'project_followers'
      get 'following'
      get 'project_following'
    end
  end

  resources :css, :controller => "css_templates", only: [:show, :create]

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
