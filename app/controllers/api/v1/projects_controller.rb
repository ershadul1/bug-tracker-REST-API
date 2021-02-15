module Api
  module V1
    class ProjectsController < ApplicationController
      def show
        projects = Project.order('created_at DESC')
        render json: { status: 'SUCCESS', message: 'Loaded projects', data: projects }, status: :ok
      end

      def create
        project = Project.create(project_params)
        if project.valid?
          render json: { status: 'SUCCESS', message: 'Created project', data: project }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Project not created', data: project.errors },
                 status: :unprocessable_entity
        end
      end

      def update
        project = Project.find_by(id: params[:id])
        project.update(project_params)

        if project.save
          render json: { status: 'SUCCESS', message: 'Updated project', data: project }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Project not updated', data: project.errors },
                 status: :unprocessable_entity
        end
      end

      def destroy
        project = Project.find_by(id: params[:id])

        if project.destroy
          render json: { status: 'SUCCESS', message: 'Destroyed project', data: project }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Project not destroyed', data: project.errors },
                 status: :unprocessable_entity
        end
      end

      private

      def project_params
        params.permit(:id, :title, :description)
      end
    end
  end
end
