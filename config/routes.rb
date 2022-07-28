Rails.application.routes.draw do
  devise_for :users

  root :to => "posts#index"

  resources :posts do
    resources :comments
  end

  get '/:short_url' => 'posts#redirect'

  namespace :admin do
    resources :posts
  end

  get '*path', to: 'posts#not_found'
end
