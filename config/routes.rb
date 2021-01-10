Rails.application.routes.draw do
  get 'bookings/index'
  get 'bookings/new'
  root 'slots#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get "sign_in", to:  "users/sessions#new"
    get "sign_out", to:  "users/sessions#destroy" 
  end

  resources :slots
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
