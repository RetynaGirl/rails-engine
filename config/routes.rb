Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/:id/merchants', to: 'merchants#index'
        get '/find', to: 'search#show'
      end

      namespace :merchants do
        get '/:id/items', to: 'items#index'
      end

      resources :items, only: [:index, :show, :create, :update, :destroy]
      resources :merchants, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
