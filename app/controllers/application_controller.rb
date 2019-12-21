class ApplicationController < ActionController::API
  attr_reader :current_user

  private

  def authenticate_user
    p request.headers['Authorization']
    token = request.headers['Authorization']&.gsub("Bearer ", "")
    p token

    payload = JwtService.decode(token)
    p payload

    return render json: {errors: 'invalid request'} unless payload

    @current_user ||= User.find_by(id: payload['user_id'])
  end
end
