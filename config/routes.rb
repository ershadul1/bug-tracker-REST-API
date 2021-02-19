Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resource :users, only: [:create, :update]
      post '/login', to: "users#login"
      get '/auto_login', to: "users#auto_login"

      resource :projects do
        get '/all', to: "projects#index"
        resource :bugs do
          get '/all', to: "bugs#index"
          resource :comments
          resource :assigns, only: [:create, :destroy]
          resource :resolves, only: [:create, :destroy]
        end
      end
    end
  end
end
