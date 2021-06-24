Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    resources :users
    post '/login', to: 'authentication#create'
      post '/signup', to: 'users#create'
  end
end
