Rails.application.routes.draw do
  root "boards#index"
  get "/board/:id", to: "boards#show"

  resources :columns, only: [:create, :update, :destroy] do
    member do
      put :move
    end
  end

  resources :tasks, only: [:create, :show, :update, :destroy] do
    member do
      put :move
    end
  end
end

