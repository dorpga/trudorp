Rails.application.routes.draw do
  get 'blog_tags/show'

  get 'blog_tags/index'

  get 'blog_comments/edit'

  get 'blog_comments/new'

  devise_for :users, path: 'accounts'

  resources :users
  resources :blog_posts, param: :slug, :path => '/blog'
  resources :blog_tags, param: :slug, :path => '/blog/tags'
  
  resources :forum_categories, :path => '/forum/categories'
  resources :forum_threads, :path => '/forum/threads'
  resources :forum_posts, :path => '/forum/posts'

  get 'forum' => 'forum_categories#index'
  get '@:id' => redirect {|params| "/users/#{params[:id]}" }

=begin
get 'forum/categories' => 'forum_categories#index'
get 'forum/categories/:id/edit' => 'forum_categories#edit', as: forum_categories_edit_path
delete 'forum/categories/:id' => 'forum_categories#delete'
get 'forum/categories/new' => 'forum_categories#new'
post 'forum/categories' => 'forum_categories#create'
get 'forum/categories/:id' => 'forum_categories#show'
patch 'forum/categories/:id' => 'forum_categories#update'
put 'forum/categories/:id' => 'forum_categories#update'

get 'forum/threads' => 'forum_threads#index'
get 'forum/threads/new' => 'forum_threads#new'
get 'forum/threads/:id/edit' => 'forum_threads#edit'
delete 'forum/threads/:id' => 'forum_threads#delete'
post 'forum/threads' => 'forum_threads#create'
get 'forum/threads/:id' => 'forum_threads#show'
post 'forum/threads/:id' => 'forum_threads#create'
patch 'forum/threads/:id' => 'forum_threads#update'
put 'forum/threads/:id' => 'forum_threads#update'

get 'forum' => 'forum_categories#index'
=end

  root 'home#index'

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
