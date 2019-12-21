class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :email, :name, :gender, :age, :bio
  field :authentication_token do |user, _options|
    JwtService.encode({user_id: user.id})
  end
end
