Crm::Application.routes.draw do

  resources :lecture_groups
  match 'lecture_groups/:id/remove_lecture' => 'lecture_groups#remove_lecture', via: [:post, :get], as: :remove_lecture
  match 'lecture_groups/:id/add_lecture'    => 'lecture_groups#add_lecture',    via: [:post, :get], as: :add_lecture

  resources :contents

  resources :rooms

  devise_for :user, :path => '', path_names: {
    sign_in: "login",
    sign_out: "logout",
    sign_up: "register",
    password: 'secret',
    confirmation: 'verification',
    edit: 'edit/profile'
  }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get '/panel' => 'home#panel'
  get '/panel/ztm' => 'home#ztm'
  get '/panel/ztm/get' => 'users#ztmTicket'
  get '/panel/ztm/leaft' => 'users#ztmTicketLeaft'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  get 'users/registrationPanel' => 'users#registrationPanel'
  get 'users/filters' => 'users#filters'
  get 'users/addbarcode' => 'users#addBarcode'
  resources :users
  
  resources :lectures

  get '/lectures/:id/attend' => 'lectures#attend', as: :attend_lecture
  get '/lectures/:id/resign' => 'lectures#resign', as: :resign_lecture
  get '/lectures/:id/remove' => 'lectures#remove', as: :remove_user
  get '/lectures/:id/add'    => 'lectures#add',    as: :add_user
  get '/lectures/:id/modify_users' => 'lectures#modify_users', as: :modify_lecture_users
  post '/lectures/:id/confirm'     => 'lectures#confirm',      as: :confirm_user_participation

  resources :profiles
  resources :stats

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
