class ApplicationController < ActionController::API
  attr_reader :current_user

  private

  def authenticate_user
    token = request.headers['Authorization']&.gsub("Bearer ", "")

    payload = JwtService.decode(token)

    return render json: {errors: 'invalid request'} unless payload

    @current_user ||= User.find_by(id: payload['user_id'])
  end
end
