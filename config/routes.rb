Rails.application.routes.draw do
  get 'customers/index'

  resources :customers do
    resources :locations do
      resources :orders, module: :locations
    end

    resources :orders
  end

end
