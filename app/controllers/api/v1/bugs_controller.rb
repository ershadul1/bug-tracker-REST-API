module Api
  module V1
    class BugsController < ApplicationController
      def index
        bugs = Bug.order('created_at DESC')
        render json: { status: 'SUCCESS', message: 'Loaded bug reports', data: bugs }, status: :ok
      end

      def show
        bug = Bug.find(params[:id])
        render json: { status: 'SUCCESS', message: 'Loaded bug report', data: bug.details }, status: :ok
      end

      def create
        bug = Bug.new(bug_params)

        if bug.save
          render json: { status: 'SUCCESS', message: 'Created bug report', data: bug }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Bug report not saved', data: bug.errors },
                 status: :unprocessable_entity
        end
      end

      def update
        bug = Bug.find_by(id: params[:id])

        if bug.update(bug_params)
          render json: { status: 'SUCCESS', message: 'Updated bug report', data: bug }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Bug report not updated', data: bug.errors },
                 status: :unprocessable_entity
        end
      end

      def destroy
        bug = Bug.find_by(id: params[:id])

        if bug.destroy
          render json: { status: 'SUCCESS', message: 'Destroyed bug report', data: bug }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Bug report not destroyed', data: bug.errors },
                 status: :unprocessable_entity
        end
      end

      private

      def bug_params
        params.permit(:title, :description, :project_id, :author_id, :priority, :status)
      end
    end
  end
end
