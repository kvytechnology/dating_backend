class UsersController < ApplicationController
  before_action :authenticate_user, except: [:create]

  def show
    render json: UserBlueprint.render(current_user, root: :data)
  end

  def create
    @user = User.new(create_params)

    if @user.save
      render json: SessionBlueprint.render(@user, root: :data)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if current_user.update(update_params)
      render json: UserBlueprint.render(current_user, root: :data)
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  def potential_match
    if User.find_by(id: params[:potential_id])
      current_user.potentials << params[:potential_id]
      current_user.save

      head 200
    else
      render json: {errors: 'invalid request'}
    end
  end

  private

  def update_params
    params.permit(:name, :bio, :age, :gender)
  end

  def create_params
    params.permit(:email, :password, :password_confirmation)
  end
end
