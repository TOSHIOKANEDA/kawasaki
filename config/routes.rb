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
  resources :slots do
    collection do
      put :power
      patch :update_date_all
    end
  end
  resources :bookings do
    collection do
      get :admin
      post :confirm
    end
  end
  get "copy/:id", to:  "slots#copy", as: 'copy_slot'

end
