Rails.application.routes.draw do
  get 'main/index'
  get 'admin/index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  resources :users, :only => [:index, :show] do
    member do
      get :wished_games
      get :owned_games
    end
  end

  resources :games do
    member do
      get :wishers
      get :owners
    end
  end

  resources :wishlists,  :only => [:create, :destroy]
  resources :ownerships, :only => [:create, :destroy]

  root 'main#index'
  match '/year/:year', to: 'main#index', via: 'get'

  get 'games/:id/edit'     => 'games#edit',         as: :edit
  get 'users/:id/wanted'   => 'users#wished_games', as: :user_wanted
  get 'users/:id/owned'    => 'users#owned_games',  as: :user_owned
  get 'games/:id/wanted'   => 'games#wishers',      as: :game_wanted
  get 'games/:id/owned'    => 'games#owners',       as: :game_owners
  get 'admin/'             => 'admin#index',        as: :admin

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'main#index'

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
