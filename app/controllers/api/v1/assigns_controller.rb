module Api
  module V1
    class AssignsController < ApplicationController
      def create
        assign = Assign.new_user_assign(@user, assign_params)
        if assign.save
          render json: { status: 'SUCCESS', message: 'Assigned bug', data: assign }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Bug not assigned', data: assign.errors },
                 status: :unprocessable_entity
        end
      end

      def destroy
        assign = Assign.find_by(bug_id: params[:bug_id])
        if assign.destroy
          render json: { status: 'SUCCESS', message: 'Destroyed bug assign', data: assign }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Assign not destroyed', data: assign.errors },
                 status: :unprocessable_entity
        end
      end

      private

      def assign_params
        params.permit(:bug_id)
      end
    end
  end
end
