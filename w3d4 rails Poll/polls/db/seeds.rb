# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do
  User.create!(user_name: Faker::Name.name)
end

10.times do
  Poll.create!(author_id: rand(10) + 1, title: Faker::Hacker.noun)
end

10.times do
  Question.create!(poll_id: rand(10) + 1, text: Faker::Hacker.say_something_smart + "?")
end

10.times do
  AnswerChoice.create!(question_id: rand(10) + 1, text: Faker::Hacker.abbreviation )
end

20.times do
  Response.create!(user_id: rand(10) + 1, question_id: rand(10) + 1, answer_choice_id: rand(10) + 1)
end