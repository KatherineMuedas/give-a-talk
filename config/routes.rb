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
end