Lakecinema::Application.routes.draw do
  root to: 'static#index'

  resources :weeks
  resources :searches, only: [:index, :show]
  controller :static do
    get :index
  end
end
