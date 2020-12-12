Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      resources :books, only: :index
    end
  end
end
