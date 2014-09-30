Rails.application.routes.draw do
  get 'tool/upload'
  post 'tool/zip'
  get 'tool/download'

  resources :genres

  resources :sale_categories

  resources :prices

  resources :sale_products

  get 'sales/:id/link' => 'sales#link', :as => 'link_sale'
  patch'sales/:id/update_product' => 'sales#update_product', :as => 'update_product'
  resources :sales

  resources :products

  devise_for :users

  get 'tasks/:id/link' => 'tasks#link', :as => 'link_to_sale'
  patch 'tasks/:id/update_sale' => 'tasks#update_sale', :as => 'link_to_update_sale'
  get 'tasks/:id/release' => 'tasks#release', :as => 'release_task'
  resources :tasks

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'tasks#index'

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
