Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    resources :users, only: %i[create]
  end
end
