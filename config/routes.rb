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

  mount_griddler

  controller :static do
    get :index
    get :about
    get :subscribe
    get :announcement
  end

  resource :contact, only: [:new, :create]
  get 'contact', to: 'contacts#new'

end
