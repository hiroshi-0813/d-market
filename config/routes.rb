Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    get 'creditcards', to: 'users/registrations#new_creditcard'
    post 'creditcards', to: 'users/registrations#create_creditcard'
  end

<<<<<<< Updated upstream
  root 'items#index'
  
=======
  root "items#index"
>>>>>>> Stashed changes
  resources :users, only: [:show, :edit, :update]do
    member do
      get 'profile'
      patch 'profile_update'
      get 'logout'
    end
    collection do
      get 'ready'
    end
  end
  namespace :items do
    resources :searches, only: [:index,:show]
    
  end

<<<<<<< Updated upstream
=======
  resources :items do
    member do
      post 'purchase'
      get 'buy'
    end
  end
  
>>>>>>> Stashed changes
  resources :credit_cards, only: [:new, :show]do
    collection do
      post 'show', to: 'credit_cards#show'
      post 'pay', to: 'credit_cards#pay'
      post 'delete', to: 'credit_cards#delete'
    end
  end
<<<<<<< Updated upstream
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
=======

>>>>>>> Stashed changes
end
