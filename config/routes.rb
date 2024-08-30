Rails.application.routes.draw do
  namespace :user do
    get 'users/mypage'
    get 'users/edit'
    get 'users/show'
    get 'users/update'
    get 'users/unsubscribe'
    get 'users/withdraw'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # アプリケーションの機能関係
  root to: 'homes#top'
  get 'homes/v_test' => 'homes#v_test', as: "test"
  
  # admin内のルーティング
  namespace :admin do
    
  end
  
  
  # # user内のルーティング
  scope module: :user do
    resources :posts
    resources :genres, except: [:show]
    
  end
  
  
    # devise関係のルーティング
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  
  devise_for :user, controllers: {
    registrations: "user/registrations",
    sessions: "user/sessions"
  }
  
  
end
