# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(1101..1200).each do |i|
  User.create(id: i, email: "user-#{i}@mail.com", password: '123456', name: Faker::Name.unique.name, gender: Faker::Gender.binary_type.downcase, age: rand(20..30))
end
