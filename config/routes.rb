Lakecinema::Application.routes.draw do

  get '/', to: 'dashboard#index', as: 'dashboard', constraints: {subdomain: 'admin'}
  root to: 'static#index'

  resource :contact, only: [:new, :create]
  get 'contact', to: 'contacts#new'

  resources :weeks, constraints: {subdomain: 'admin'}
  resources :newsletters, constraints: {subdomain: 'admin'}
  resources :searches, only: [:index, :show], constraints: {subdomain: 'admin'}
  controller :static do
    get :index
    get :about
    get :subscribe
  end
end
