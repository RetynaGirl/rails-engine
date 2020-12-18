Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/:id/merchants', to: 'merchants#index'
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      namespace :merchants do
        get '/:id/items', to: 'items#index'
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/most_revenue', to: 'statistics#most_revenue'
        get '/most_items_sold', to: 'statistics#most_items_sold'
        get '/:id/revenue', to: 'statistics#revenue'
      end

      get '/revenue', to: 'statistics#revenue_date_range'

      resources :items, only: [:index, :show, :create, :update, :destroy]
      resources :merchants, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
