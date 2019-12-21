class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :email, :name, :gender, :age, :bio
end
