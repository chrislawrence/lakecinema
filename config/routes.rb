Lakecinema::Application.routes.draw do


  constraints(subdomain: 'admin') do
    get '/', to: 'dashboard#index', as: 'dashboard'
    resources :weeks
    resources :newsletters
    resources :searches, only: [:index, :show]
    get :login, to: 'sessions#new'
    post :login, to: 'sessions#create'
  end

  root to: 'static#index'

  controller :static do
    get :index
    get :about
    get :subscribe
  end

  resource :contact, only: [:new, :create]
  get 'contact', to: 'contacts#new'

end
