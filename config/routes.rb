Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # アプリケーションの機能関係
  root to: 'homes#top'
  
  # admin内のルーティング
  namespace :admin do
    
  end
  
  
  # # user内のルーティング
  scope module: :user do
    resources :posts
    resources :genres, except: [:show]
    resources :users, except: [:new, :index, :destroy] do
      collection do
        get 'mypage'
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
    
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
