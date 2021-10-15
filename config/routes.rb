Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :auths, only: %i[] do
        collection do
          post :sign_in
        end
      end
    end
  end
end
