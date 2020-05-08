Rails.application.routes.draw do
  root to: 'courses#index'
  resources :courses, only: [:index, :show] do
    resources :groups, only: [] do
      post :join
    end
  end

  # resources :groups, only: [] do

  # end
end
