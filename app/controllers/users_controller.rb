class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_user, except: [:create]

  def show
    render json: UserBlueprint.render(@user, root: :data)
  end

  def create
    @user = User.new(create_params)

    if @user.save
      render json: UserBlueprint.render(@user, root: :data)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(update_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
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

  def set_user
    @user = User.find(params[:id])
  end

  def update_params
    params.permit(:name, :bio, :age, :gender)
  end

  def create_params
    params.permit(:email, :password, :password_confirmation)
  end
end
