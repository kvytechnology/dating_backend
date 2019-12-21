class SessionsController < ApplicationController
  def create
    user = User.find_by(email: sessions_params[:email]).try(:authenticate, sessions_params[:password])

    if user
      render json: SessionBlueprint.render(user, root: :data)
    else
      render json: {errors: 'invalid email/password'}
    end
  end

  private

  def sessions_params
    params.permit(:email, :password)
  end
end
