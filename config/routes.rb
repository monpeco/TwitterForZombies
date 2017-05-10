Rails.application.routes.draw do

namespace :admin do
   resources :photos
end

#scope module: 'admin' do
 # get '/photos', to: 'photos#index' # this route in scope
#end

  #root 'welcome#index'    #tells Rails to map requests to the root of the application to the welcome controller's index action
  root 'zombies#index'    #Root to tweets index (temporal)
  
  get 'welcome/index'     #tells Rails to map requests to http://localhost:3000/welcome/index to the welcome controller's index action
  
  get 'articles/alternative' => 'articles#alternative'
  resources :articles     #create a new resource 'articles'
  
  # root "humen#index" # get "/", "zombies#index" 

  get 'idiomatic' => 'zombies#idiomatic' #link will be /root/idiomatic
  
  get 'zombies/wannabe' => 'zombies#wannabe'
  get 'zombies/add_to_cookie/:id' => 'zombies#add_to_cookie'

  resources :zombies 
  resources :tweets       #Root to tweets index (temporal)

  """
  resources :zombies do
    resources :tweets
  end
  """
  resources :humen
  


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
