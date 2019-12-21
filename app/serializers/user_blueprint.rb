class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :email
  field :authentication_token do |user, _options|
    JwtService.encode({user_id: user.id})
  end
end
