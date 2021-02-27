module Api
  module V1
    class ProjectsController < ApplicationController
      def index
        projects = Project.order('created_at DESC')
        render json: { status: 'SUCCESS', message: 'Loaded projects', data: projects }, status: :ok
      end

      def show
        project = Project.find(params[:id])

        if project
          render json: {
            status: 'SUCCESS', message: 'Loaded project', data: { project: project, bugs: project.bugs }
          }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Project not found' },
                 status: :unprocessable_entity
        end
      end

      def create
        project = Project.new(project_params)

        if project.save
          render json: { status: 'SUCCESS', message: 'Created project', data: project }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Project not created', data: project.errors },
                 status: :unprocessable_entity
        end
      end

      def update
        project = Project.find(params[:id])

        if project.update(project_params)
          render json: { status: 'SUCCESS', message: 'Updated project', data: project }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Project not updated', data: project.errors },
                 status: :unprocessable_entity
        end
      end

      def destroy
        project = Project.find(params[:id])

        if project.destroy
          render json: { status: 'SUCCESS', message: 'Destroyed project', data: project }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Project not destroyed', data: project.errors },
                 status: :unprocessable_entity
        end
      end

      private

      def project_params
        params.permit(:title, :description)
      end
    end
  end
end
