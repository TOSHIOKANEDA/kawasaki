Rails.application.routes.draw do
  root 'bookings#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get "sign_in", to:  "users/sessions#new"
    get "sign_out", to:  "users/sessions#destroy" 
  end

  resources :users, only: [:index, :show, :update, :edit]
  resources :slots
  resources :bookings do
    collection do
      post :confirm
    end
  end
  put "power", to:  "slots#power"
  get "copy/:id", to:  "slots#copy", as: 'copy_slot'
  patch "update_date_all", to:  "slots#update_date_all" 
end
