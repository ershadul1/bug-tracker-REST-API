module Api
  module V1
    class SessionsController < ApplicationController
      before_action :authorized, except: :create

      def create
        @user = User.find_by(username: params[:username])

        if @user&.authenticate(params[:password])
          token = encode_token({ user_id: @user.id })
          render json: { status: 'SUCCESS', user: @user, token: token }, status: :ok
        else
          render json: { status: 'FAILURE', error: 'Invalid username or password' },
                 status: :unprocessable_entity
        end
      end

      private

      def session_params
        params.permit(:username, :password)
      end
    end
  end
end
