Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "amplifiers#index", as: :authenticated_root
    get "new", to: "amplifiers#new"
  end

  unauthenticated :user do
    root "pages#about", as: :unauthenticated_root
  end

  get "about", to: "pages#about"
end
