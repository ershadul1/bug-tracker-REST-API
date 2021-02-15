module Api
  module V1
    class CommentsController < ApplicationController
      def show
        comments = Comment.where(bug_id: params[:bug_id]).order('created_at DESC')
        render json: { status: 'SUCCESS', message: 'Loaded comments', data: comments }, status: :ok
      end

      def create
        comment = Comment.create(comment_params)
        if comment.valid?
          render json: { status: 'SUCCESS', message: 'Created comment', data: comment }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Comment not saved', data: comment.errors },
                 status: :unprocessable_entity
        end
      end

      def update
        comment = Comment.find_by(id: params[:id])
        comment.update(comment_params)

        if comment.save
          render json: { status: 'SUCCESS', message: 'Updated comment', data: comment }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Comment not updated', data: comment.errors },
                 status: :unprocessable_entity
        end
      end

      def destroy
        comment = Comment.find_by(id: params[:id])

        if comment.destroy
          render json: { status: 'SUCCESS', message: 'Destroyed comment', data: comment }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Comment not destroyed', data: comment.errors },
                 status: :unprocessable_entity
        end
      end

      private

      def comment_params
        params.permit(:id, :bug_id, :content, :user_id)
      end
    end
  end
end
