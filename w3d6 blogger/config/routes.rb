Blogger::Application.routes.draw do
  root to: 'articles#index'
  resources :articles do
    resources :comments
  end

  resources :tags, only: [:show, :index] do
    resources :articles, only: :index
  end
  

end
