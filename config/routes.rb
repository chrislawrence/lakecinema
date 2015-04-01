Lakecinema::Application.routes.draw do

  scope '/a' do
    get '/' => 'dashboard#index', as: 'admin'
    resources :weeks
    resources :newsletters
  end
  get :login, to: 'sessions#new'
  post :login, to: 'sessions#create'
  get :logout, to: 'sessions#destroy', action: :destroy
  
  resources :searches, only: [:index, :show]

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
