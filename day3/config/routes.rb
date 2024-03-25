Rails.application.routes.draw do
  resources :questions
  root to: 'application#index'

  get '/yo', to: 'random#yo'
end
