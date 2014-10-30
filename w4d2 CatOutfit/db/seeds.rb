# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
COLORS = ["calico", "black", "white", "tuxedo", "leopard", "tabby"]

ActiveRecord::Base.transaction do
  10.times do 
    User.create!(user_name: Faker::Internet.user_name, 
    password: Faker::Internet.password)
  end

  20.times do 
    Cat.create!(birth_date: Faker::Date.backward(5475), color: COLORS.sample, 
      name: Faker::Name.first_name, sex: ["M", "F"].sample, 
      description: Faker::Hacker.say_something_smart, user_id: rand(1..10))
  end
  
  30.times do
    CatRentalRequest.create!(cat_id: rand(1..20), start_date: Faker::Date.backward(300),
    end_date: Faker::Date.forward(300), user_id: rand(1..10))
  end
end