Rails.application.routes.draw do
  root "boards#index"
  get "/board/:id", to: "boards#show"
end

