class ApplicationController < ActionController::API
  before_action :authorized

  def logged_in_user
    return unless Encryption.new(decoded_token)

    user_id = decoded_token[0]['user_id']
    @user = User.find_by(id: user_id)
  end

  def logged_in?
    logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
