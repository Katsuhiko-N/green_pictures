Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # admin内のルーティング
  namespace :admin do
    # 投稿関係機能
    resources :posts, except: [:new, :create, :edit, :update] do
      # 投稿コメント機能
      resources :comments, only: [:destroy]
    end
    
    # 投稿コメント一覧機能
    resources :comments, only: [:index] do
      member do
        delete 'comments' => 'comments#idx_destroy', as: "idx_destroy"
      end
    end
    # ユーザー機能
    resources :users, except: [:new, :create, :edit, :destroy]
    
    # 検索機能
    get 'search' => 'searches#search', as: "search"
  end
  
  
  # user内のルーティング
  scope module: :user do
    # 投稿機能
    resources :posts do
      # 投稿コメント機能
      resources :comments, only: [:create, :destroy]
    end
    
    # ジャンル機能は後で実装
    # resources :genres, except: [:show]
    
    # ユーザー機能
    resources :users, except: [:new, :index, :edit, :destroy] do
      collection do
        get 'mypage'
        get 'mypage/edit' => 'users#edit', as: "edit"
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
    
    # 検索機能
    get 'search' => 'searches#search', as: "search"
    
    # グループ機能
    resources :groups do
      resources :group_members, only:[:create, :destroy]
    end
    
  end
  
  
# その他のアプリケーションのページ・機能
  # トップページ
  root to: 'homes#top'
  
    # devise関係のルーティング
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  devise_for :user, skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: "user/sessions"
  }
  
end
