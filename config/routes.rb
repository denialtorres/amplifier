Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "amplifiers#index", as: :authenticated_root
    get 'amplifiers/new', to: 'amplifiers#new_amplifier', as: 'new_amplifier'

    resources :amplifiers do
      post 'create_conversation', on: :collection
    end
  end

  unauthenticated :user do
    root "pages#about", as: :unauthenticated_root
  end

  get "about", to: "pages#about"
end
