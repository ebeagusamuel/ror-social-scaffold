# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Like.destroy_all
Comment.destroy_all
FriendRequest.destroy_all
Post.destroy_all
User.destroy_all

5.times do
  user = User.create!(name: Faker::Name.first_name,
                      email: Faker::Internet.email, password: 'password',
                      password_confirmation: 'password')
  Post.create!(user_id: user.id, content: Faker::Lorem.paragraph_by_chars)
end
