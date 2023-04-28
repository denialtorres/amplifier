require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    mount Sidekiq::Web => "/sidekiq"

    root "amplifiers#index", as: :authenticated_root
    get 'amplifiers/new', to: 'amplifiers#new_amplifier', as: 'new_amplifier'

    resources :amplifiers do
      post 'create_conversation', on: :collection
      post 'create_custom_conversation', on: :collection
      post 'attachments', on: :collection
    end
  end

  unauthenticated :user do
    root "pages#about", as: :unauthenticated_root
  end

  get "about", to: "pages#about"
  resources :amplifier_prompts, only: [:index]
  get 'get_partial', to: 'amplifier_prompts#get_partial'
  post 'upload_url', to: 'amplifiers#upload_url', as: 'upload_url'
end
