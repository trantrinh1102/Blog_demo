User.create!(name:  "admin",
             email: "admin@example.com",
             password:              "password",
             password_confirmation: "password",
             admin: true)

9.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
5.times do
  content = Faker::Lorem.sentence(50)
  title = Faker::Lorem.sentence(4)
  users.each { |user| user.entries.create!(title: title, content: content) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..5]
followers = users[3..4]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

