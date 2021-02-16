module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorized, only: %i[auto_login update]

      def create
        @user = User.create(user_params)
        if @user.valid?
          token = encode_token({ user_id: @user.id })
          render json: { user: @user, token: token }
        else
          render json: { error: 'Invalid username or password' }
        end
      end

      def login
        @user = User.find_by(username: params[:username])

        if @user&.authenticate(params[:password])
          token = encode_token({ user_id: @user.id })
          render json: { user: @user, token: token }
        else
          render json: { error: 'Invalid username or password' }
        end
      end

      def auto_login
        render json: @user
      end

      def update
        @user = User.find_by(id: params[:id])
        @user.update(user_params)

        if @user.save
          token = encode_token({ user_id: @user.id })
          render json: { user: @user, token: token }
        else
          render json: { error: 'Unable to change username and password' }
        end
      end

      private

      def user_params
        params.permit(:username, :password, :id)
      end
    end
  end
end
