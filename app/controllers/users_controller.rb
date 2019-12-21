class UsersController < ApplicationController
  before_action :authenticate_user, except: [:create]

  def radar
    reject_ids = current_user.uninterested
    below_age = current_user.age - 5
    above_age = current_user.age + 5
    gender =
      case current_user.gender
      when 'male'
        'female'
      when 'female'
        'male'
      end
    user = User.where.not(id: reject_ids).where('age BETWEEN ? AND ?', below_age, above_age).where(
      gender: gender
    ).sample

    if user
      render json: UserBlueprint.render(user, root: :data, view: :radar)
    else
      render json: {errors: 'update your profile to find people'}
    end
  end

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

  def reject
    user = User.find_by(id: params[:reject_id])

    if user
      current_user.uninterested << user.id
      current_user.save

      render json: {data: 'updated'}
    else
      render json: {errors: 'invalid request'}
    end
  end

  def potential_match
    potential = User.find_by(id: params[:potential_id])
    if potential
      current_user.potentials << params[:potential_id]
      current_user.save

      match = potential.potentials.include?(current_user.id.to_s)

      reject_ids = current_user.uninterested + current_user.potentials
      below_age = current_user.age - 5
      above_age = current_user.age + 5
      gender =
        case current_user.gender
        when 'male'
          'female'
        when 'female'
          'male'
        end

      user = User.where.not(id: reject_ids).where('age BETWEEN ? AND ?', below_age, above_age).where(
      gender: gender
    ).sample

      if user
        render json: {data: {user: UserBlueprint.render(user), match: match}}
      else
        render json: {data: 'Stop using this app'}
      end
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
