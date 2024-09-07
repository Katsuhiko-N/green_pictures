# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

taro = User.find_or_create_by!(email: "Taro@example.com") do |user|
  user.name = "太郎"
  user.nickname = "タロー"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

jiro = User.find_or_create_by!(email: "Jiro@example.com") do |user|
  user.name = "二郎"
  user.nickname = "ジロー"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

hanako = User.find_or_create_by!(email: "Hanako@example.com") do |user|
  user.name = "花子"
  user.nickname = "ハナコ"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end

Post.find_or_create_by!(name: "庭に生えた草") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  post.body = "名前がわからない草です。"
  post.user = taro
end

Post.find_or_create_by!(name: "珍しいキノコ") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  post.body = "キノコ見つけた！"
  post.user = jiro
end

Post.find_or_create_by!(name: "綺麗な花") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
  post.body = '綺麗な花が咲いてた！'
  post.user = hanako
end