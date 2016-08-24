Rails.application.routes.draw do
  root "static_pages#home"
  get     '/help',      to: 'static_pages#help'
  get     '/about',     to: 'static_pages#about'
  get     '/contact',   to: 'static_pages#contact'
  get     '/signup',    to: 'users#new'
  post    '/signup',    to: 'users#create'
  get     '/login',     to: 'sessions#new'
  post    '/login',     to: 'sessions#create'
  delete  '/logout',    to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  get '/weibo_record', to: 'weibo_pages#index'
  resources :charts, only: [] do
    collection do
      get 'mblog_by_gender'
      get 'mblog_top_source'
      get 'mblog_group_by_day'
      get 'mblog_group_by_hour_of_day'
      get 'mblog_publish_top_source'
      get 'mblog_share_top_source'
      get 'mblog_today_count'
    end
  end
end
