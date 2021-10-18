Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :auths, only: %i[] do
        collection do
          post :sign_in
        end
      end

      resources :technologies, only: %i[index create update destroy]
      resources :projects, except: %i[new edit]
      resources :developers, except: %i[new edit]
    end
  end
end
