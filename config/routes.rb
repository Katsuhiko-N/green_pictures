Rails.application.routes.draw do
  
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  
  devise_for :user, controllers: {
    registrations: "user/registrations",
    sessions: "user/sessions"
  }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: 'homes#top'
  get 'homes/v_test' => 'homes#v_test', as: "test"
  
  # admin内のルーティング
  namespace :admin do
    
  end
  
  
  
  # # user内のルーティング
  scope module: :user do
    
  end
  
  
end
