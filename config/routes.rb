Newbie::Application.routes.draw do
  devise_for :users
  resources :cars
  resources :tanking_logs
  resources :gas_stations

  root to: "devise/sessions#new"
end
