Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "amplifiers#index", as: :authenticated_root
  end

  unauthenticated :user do
    root "pages#about", as: :unauthenticated_root
  end

  get "about", to: "pages#about"
end
