require 'Faker'

10.times do
  User.create!(first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name,
               user_name: Faker::Internet.user_name,
               password: "password",
               email: Faker::Internet.email)
end



10.times do
  id = 1 + rand(10)
  user = User.find(id)
  Question.create!(
    title: Faker::Company.bs,
    body: Faker::Lorem.paragraph,
    user: user
    )

end
