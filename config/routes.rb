Lakecinema::Application.routes.draw do

  scope '/admin' do
    get '/' => 'dashboard#index', as: 'admin'
    resources :weeks
    resources :newsletters
  end
  get :login, to: 'sessions#new'
  post :login, to: 'sessions#create'
  get :logout, to: 'sessions#destroy', action: :destroy
  
  resources :searches, only: [:index, :show]
  resources :movies, only: :show

  root to: 'static#index'

  controller :static do
    get :index
    get :about
    get :subscribe
    get :contact
  end
end
