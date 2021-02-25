module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorized, only: %i[update show]

      def show
        render json: { status: 'SUCCESS', user: @user }, status: :ok
      end

      def create
        @user = User.new(user_params)

        if @user.save
          encryption = Encryption.new
          token = encryption.encode_token({ user_id: @user.id }).
          render json: { status: 'SUCCESS', user: @user, token: token }, status: :ok
        else
          render json: { status: 'FAILURE', error: 'Invalid username or password' },
                 status: :unprocessable_entity
        end
      end

      def update
        @user = User.find_by(id: params[:id])

        if @user.update(user_params)
          encryption = Encryption.new
          token = encryption.encode_token({ user_id: @user.id })
          render json: { status: 'SUCCESS', user: @user, token: token }, status: :ok
        else
          render json: { status: 'FAILURE', error: 'Unable to change username and password' },
                 status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:username, :password)
      end
    end
  end
end
