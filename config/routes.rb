Rails.application.routes.draw do
  root 'items#top'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  
  resources :users, only: [:index] do
    collection do
      get 'logout'
    end 
  end
  resources :credit_cards, only: [:index, :new, :create, :show, :destroy]

  resources :purchase, only:[:index] do
    collection do
      get 'done', to: 'purchase#done'
    end
    member do
      get 'index', to: 'purchase#index'
      post 'pay', to: 'purchase#pay'
    end
  end
  resources :items do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'search', to: 'items#search'
    end
  end

  resources :categories, only: :show
  resources :images, only: [:index, :new, :show]
end


