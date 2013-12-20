GiveATalk::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, 
    controllers: {
      registrations: "registrations"
    },
    path: '',
    path_names: {
      sign_in: 'sign-in',
      sign_out: 'sign-out',
      password: 'password',
      confirmation: 'verify',
      unlock: 'unblock',
      registration: 'sign-up',
      sign_up: ''
    }
  resources :users
  resources :events
  post 'events/:id/attend', to: 'events#attend', as: :attend_event
  post 'events/:id/unattend', to: 'events#unattend', as: :unattend_event
  resources :organizations do 
    resources :events
  end
  resources :locations, only: [:new, :create, :update, :edit, :destroy]
  get '/locations/:location_id/set/:event_id', to: 'locations#set_location', as: :set_location
  get '/locations/subregion_options', to: 'locations#subregion_options', as: :subregion_options

end