Rails.application.routes.draw do
  resources :cats do
    resources :cat_rental_requests, only: [:index]
  end
  resources :cat_rental_requests, except: [:index] do
    post 'approve', :on => :member
    post 'deny', :on => :member
  end
  resources :users, only: [:create, :new, :show]
  
  resource :session, only: [:create, :destroy, :new]
end
