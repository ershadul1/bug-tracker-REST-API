Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resource :users, only: [:create, :update]
      post '/login', to: "users#login"
      get '/auto_login', to: "users#auto_login"

      resource :projects do
        resource :bugs do
          resource :comments
        end
      end
    end
  end
end
