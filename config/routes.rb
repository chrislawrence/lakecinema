Lakecinema::Application.routes.draw do
  resources :weeks
  resources :searches, only: [:index, :show]
end
