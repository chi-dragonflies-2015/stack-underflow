require 'Faker'

10.times do
  User.create!(first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name,
               user_name: Faker::Internet.user_name,
               password: "password",
               email: Faker::Internet.email)
end


