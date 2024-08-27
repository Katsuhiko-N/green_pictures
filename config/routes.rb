Rails.application.routes.draw do
  devise_for :admin, skip[:registration, :passwords]
  devise_for :public, skip[:passwords]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: 'homes#top'
  
  # admin内のルーティング
  namespace :admin do
    
  end
  
  
  
  # # user内のルーティング
  scope module: :user do
    
  end
  
  
end
