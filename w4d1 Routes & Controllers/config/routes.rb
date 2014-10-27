Rails.application.routes.draw do
  resources :users, except: [:new, :edit] do
    resources :contacts, only: :index
  end
  
  resources :contacts, except: [:new, :edit, :index]
  resources :contactshares, only: [:create, :destroy]
  # get 'users/:id' => 'users#show'
#   get 'users' => 'users#index'
#   post 'users' => 'users#create'
#   get 'users/new' => 'users#new'
#   get 'users/:id/edit' => 'users#edit'
#   patch 'users/:id' => 'users#update'
#   put '/users/:id' => 'user#update'
#   delete 'users/:id' => 'users#destroy'
end
