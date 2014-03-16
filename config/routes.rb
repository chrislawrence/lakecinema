Lakecinema::Application.routes.draw do

  get '/', to: 'dashboard#index', as: 'dashboard', constraints: {subdomain: 'admin'}
  root to: 'static#index'

  resources :weeks
  resources :newsletters
  resources :searches, only: [:index, :show]
  controller :static do
    get :index
  end
end
