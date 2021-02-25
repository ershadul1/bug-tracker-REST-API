class ApplicationController < ActionController::API
  before_action :authorized

  def logged_in_user
    encryption = Encryption.new(request)
    decode = encryption.decoded_token
    return unless decode

    user_id = decode[0]['user_id']
    @user = User.find_by(id: user_id)
  end

  def logged_in?
    logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
