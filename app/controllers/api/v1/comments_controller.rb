module Api
  module V1
    class CommentsController < ApplicationController
      def show
        comments = Comment.bug_comments(params[:bug_id])
        render json: { status: 'SUCCESS', message: 'Loaded comments', data: comments }, status: :ok
      end

      def create
        comment = Comment.new_user_comment(@user, comment_params)

        if comment.save
          render json: { status: 'SUCCESS', message: 'Created comment', data: comment }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Comment not saved', data: comment.errors },
                 status: :unprocessable_entity
        end
      end

      def update
        comment = Comment.find_by(id: params[:id])

        if comment.update(comment_params)
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
        params.permit(:content, :bug_id)
      end
    end
  end
end
