Rails.application.routes.draw do
  devise_for :users
  get "about", to: "pages#about"

  authenticated :user do
    root "pages#home", as: :authenticated_root
  end

  unauthenticated :user do
    root "pages#about", as: :unauthenticated_root
  end
end
