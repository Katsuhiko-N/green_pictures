# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "seed生成開始"

puts "seed人物生成開始"
taro = User.find_or_create_by!(email: "Taro@example.com") do |user|
  user.name = "太郎"
  user.nickname = "タロー"
  user.body = "珍しい植物が見たい"
  user.password = "password"
  user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

jiro = User.find_or_create_by!(email: "Jiro@example.com") do |user|
  user.name = "二郎"
  user.nickname = "ジロー"
  user.body = "キノコを見つけたい"
  user.password = "password"
  user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

hanako = User.find_or_create_by!(email: "Hanako@example.com") do |user|
  user.name = "花子"
  user.nickname = "ハナコ"
  user.body = "花が好きです"
  user.password = "password"
  user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end
puts "seed人物生成完了"



puts "seed投稿生成開始"
Post.find_or_create_by!(title: "庭に生えた草") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  post.body = "名前がわかりませんが大きいです。"
  post.user = taro
end

Post.find_or_create_by!(title: "キノコ?") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  post.body = "これはキノコでしょうか？"
  post.user = jiro
end

Post.find_or_create_by!(title: "綺麗な花") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
  post.body = '綺麗な花が咲いてた！'
  post.user = hanako
end
puts "seed投稿生成完了"



puts "seedコメント生成開始"
Comment.find_or_create_by!(id: "1") do |comment|
  comment.post_id = "1"
  comment.user_id = "3"
  comment.body = "とっても大きくてワラビみたいな葉っぱですね"
end

Comment.find_or_create_by!(id: "2") do |comment|
  comment.post_id = "2"
  comment.user_id = "1"
  comment.body = "冬虫夏草かな？見た感じはとっても小さそうだし、キノコっぽい"
end

Comment.find_or_create_by!(id: "3") do |comment|
  comment.post_id = "3"
  comment.user_id = "2"
  comment.body = "隙間に見えるシロツメクサとはまた違った花だね"
end

puts "seedコメント生成完了"



puts "管理者生成開始"
admin = Admin.find_or_create_by!(email: ENV['AD_EMAIL'] ) do |admin|
  admin.password = ENV['AD_PASSWORD']
end
puts "管理者生成完了"

puts "seed生成完了"