Rails.application.routes.draw do
  devise_for :users, path: 'accounts'

  resources :users
  resources :pages, param: :path

  resources :blog_posts, param: :slug, :path => '/blog'
  resources :blog_tags, param: :slug, :path => '/blog/tags'

  resources :forum_categories, :path => '/forum/categories'
  resources :forum_threads, :path => '/forum/threads'
  resources :forum_posts, :path => '/forum/posts'

  get 'forum' => 'forum_categories#index'
  get '@:id' => redirect {|params| "/users/#{params[:id]}" }

  root 'home#index'
  
  get ':path' => 'pages#show'
end
