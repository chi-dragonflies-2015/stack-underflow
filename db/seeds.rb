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
  user.questions.create!(
    title: Faker::Company.bs,
    body: Faker::Lorem.paragraph
    )

  comment_count = 1 + rand(6)
  comment_count.times do
    user_id = 1 + rand(10)
    commenter = User.find(user_id)
    Question.last.comments.create!(body: Faker::Company.catch_phrase, user: commenter)
  end
end

20.times do
  id = 1 + rand(10)
  user = User.find(id)
  question = Question.find(id)
  question.answers.create!(
    title: Faker::Company.bs,
    body: Faker::Lorem.paragraph,
    user: user
    )

  comment_count = 1 + rand(6)
  comment_count.times do
    user_id = 1 + rand(10)
    commenter = User.find(user_id)
    Answer.last.comments.create!(body: Faker::Company.catch_phrase, user: commenter)
  end


end




