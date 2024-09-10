Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # admin内のルーティング
  namespace :admin do
    
  end
  
  
  # user内のルーティング
  scope module: :user do
    resources :posts
    # ジャンル機能は後で実装
    # resources :genres, except: [:show]
    resources :users, except: [:new, :index, :edit, :destroy] do
      collection do
        get 'mypage'
        get 'mypage/edit' => 'users#edit', as: "edit"
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
  end
  
  
# その他のアプリケーションのページ・機能
  # トップページ
  root to: 'homes#top'
  # 検索機能
  get 'search' => 'searches#search', as: "search"
  
  
    # devise関係のルーティング
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  
  devise_for :user, controllers: {
    registrations: "user/registrations",
    sessions: "user/sessions"
  }
  
  
end
