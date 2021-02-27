Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resource :users, only: [:show, :create, :update]
      resource :sessions, only: [:create]

      resources :projects do
        resources :bugs do
          resource :comments
          resource :assigns, only: [:create, :destroy]
          resource :resolves, only: [:create, :destroy]
        end
      end
    end
  end
end
