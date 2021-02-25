module Api
  module V1
    class ResolvesController < ApplicationController
      def create
        resolve = Resolve.new(user_id: @user.id, bug_id: params[:bug_id])

        if resolve.save
          render json: { status: 'SUCCESS', message: 'Resolved bug', data: resolve }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Bug not resolved', data: resolve.errors },
                 status: :unprocessable_entity
        end
      end

      def destroy
        resolve = Resolve.find_by(bug_id: params[:bug_id])

        if resolve.destroy
          render json: { status: 'SUCCESS', message: 'Destroyed bug resolve', data: resolve }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Resolve not destroyed', data: resolve.errors },
                 status: :unprocessable_entity
        end
      end

      private

      def resolve_params
        params.permit(:bug_id)
      end
    end
  end
end
