class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :email, :name, :gender, :age, :bio

  view :radar do |user, _options|
    association :images, blueprint: ImageBlueprint
  end
end
