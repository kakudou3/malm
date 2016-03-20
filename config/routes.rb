Rails.application.routes.draw do

  root :controller => 'users', :action => 'index'

  #constraints -> request { ApplicationController.helpers.logged_in? } do
    # ログインしてる時のパス
  # root :controller => 'items', :action => 'index'
  #end
  # ログインしてない時のパス
  # root :controller => 'users', :action => 'index'

  get 'settings/index'

  get 'daily_items' => 'daily_items#index'
  get 'daily_items/page/:id' => 'daily_items#show'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  get 'diary'      => 'items#index'
  post 'diary'     => 'items#index'

  # ajax
  post 'items/create'
  post 'items/edit'
  post 'items/delete'
  post 'items/create_file'

  get 'diary/index'
  post 'diary/create'

  post 'users/create'

  get 'signup' => 'users#signup'

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
