# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "seed生成開始"

puts "seed人物生成開始"
taro = User.find_or_create_by!(email: "Taro@example1.com") do |user|
  user.name = "太郎"
  user.nickname = "タロー"
  user.body = "珍しい植物をさがしています"
  user.password = "password001"
  user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

jiro = User.find_or_create_by!(email: "Jiro@example2.com") do |user|
  user.name = "二郎"
  user.nickname = "ジロー"
  user.body = "キノコを見つけたい"
  user.password = "password002"
  user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

hanako = User.find_or_create_by!(email: "Hanako@example3.com") do |user|
  user.name = "花子"
  user.nickname = "ハナコ"
  user.body = "花が好きです"
  user.password = "password003"
  user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end
puts "seed人物生成完了"



puts "seed投稿生成開始"
Post.find_or_create_by!(title: "庭に生えた草") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  post.body = "名前がわかりませんが大きいです。ワラビに似ていますがどうでしょう？"
  post.user = taro
end

Post.find_or_create_by!(title: "キノコ?") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  post.body = "道端の古い丸太になんか生えていました。もしかしてこれはキノコでしょうか？"
  post.user = jiro
end

Post.find_or_create_by!(title: "綺麗な花") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
  post.body = 'ふと足元をみたら綺麗な花が咲いてたので！'
  post.user = hanako
end

Post.find_or_create_by!(title: "カンバタケ？") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post6.jpg"), filename:"sample-post2.jpg")
  post.body = "雨上がり散歩してたら枯れ木にたくさんのキノコが！？"
  post.user = jiro
end

Post.find_or_create_by!(title: "キノコ大量発生") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post7.jpg"), filename:"sample-post2.jpg")
  post.body = "名前がわからないけどめっちゃ生えてた！"
  post.user = taro
end

puts "seed投稿生成完了"



puts "seedコメント生成開始"
Comment.find_or_create_by!(id: "1") do |comment|
  comment.post_id = "1"
  comment.user_id = "3"
  comment.body = "とっても大きいですね！たしかにワラビみたいな葉っぱです"
end

Comment.find_or_create_by!(id: "2") do |comment|
  comment.post_id = "2"
  comment.user_id = "1"
  comment.body = "冬虫夏草かな？見た感じはとっても小さそうだし、キノコっぽい"
end

Comment.find_or_create_by!(id: "3") do |comment|
  comment.post_id = "3"
  comment.user_id = "2"
  comment.body = "隙間に見えるシロツメクサとはまた違った花だね、なんだろう"
end

Comment.find_or_create_by!(id: "4") do |comment|
  comment.post_id = "4"
  comment.user_id = "1"
  comment.body = "がっつり生えてる( ﾟДﾟ)！？"
end

Comment.find_or_create_by!(id: "5") do |comment|
  comment.post_id = "5"
  comment.user_id = "2"
  comment.body = "奥にもたくさん生えてそう！"
end

puts "seedコメント生成完了"


puts "seedタグ生成開始"
Tag.find_or_create_by!(id: "1") do |tag|
  tag.name = "野草"
end

Tag.find_or_create_by!(id: "2") do |tag|
  tag.name = "きのこ"
end

Tag.find_or_create_by!(id: "3") do |tag|
  tag.name = "秋"
end

Tag.find_or_create_by!(id: "4") do |tag|
  tag.name = "白い花"
end

Tag.find_or_create_by!(id: "5") do |tag|
  tag.name = "名前がわからない"
end

Tag.find_or_create_by!(id: "6") do |tag|
  tag.name = "カンバタケ？"
end

Tag.find_or_create_by!(id: "7") do |tag|
  tag.name = "雨上がり"
end

puts "seedタグ生成完了"



puts "seedタグリスト生成開始"
TagList.find_or_create_by!(id: "1") do |t_list|
  t_list.post_id = "1"
  t_list.tag_id = "1"
end

TagList.find_or_create_by!(id: "2") do |t_list|
  t_list.post_id = "2"
  t_list.tag_id = "2"
end

TagList.find_or_create_by!(id: "3") do |t_list|
  t_list.post_id = "3"
  t_list.tag_id = "3"
end

TagList.find_or_create_by!(id: "4") do |t_list|
  t_list.post_id = "1"
  t_list.tag_id = "5"
end

TagList.find_or_create_by!(id: "5") do |t_list|
  t_list.post_id = "2"
  t_list.tag_id = "5"
end

TagList.find_or_create_by!(id: "6") do |t_list|
  t_list.post_id = "3"
  t_list.tag_id = "4"
end

TagList.find_or_create_by!(id: "7") do |t_list|
  t_list.post_id = "4"
  t_list.tag_id = "2"
end

TagList.find_or_create_by!(id: "8") do |t_list|
  t_list.post_id = "4"
  t_list.tag_id = "6"
end

TagList.find_or_create_by!(id: "9") do |t_list|
  t_list.post_id = "4"
  t_list.tag_id = "7"
end

TagList.find_or_create_by!(id: "10") do |t_list|
  t_list.post_id = "5"
  t_list.tag_id = "3"
end

TagList.find_or_create_by!(id: "11") do |t_list|
  t_list.post_id = "5"
  t_list.tag_id = "5"
end

TagList.find_or_create_by!(id: "12") do |t_list|
  t_list.post_id = "5"
  t_list.tag_id = "7"
end

puts "seedタグリスト生成完了"




puts "seedグループ生成開始"
Group.find_or_create_by!(id: "1") do |group|
  group.g_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-group1.jpg"), filename:"sample-post1.jpg")
  group.title = "野草探検隊"
  group.body = "庭の手入れがてら見かけた植物の情報共有、草刈りの悩みなどコメントや投稿で情報共有しましょう"
  group.owner_id = "1"
end

Group.find_or_create_by!(id: "2") do |group|
  group.g_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-group2.jpg"), filename:"sample-post2.jpg")
  group.title = "キノコ同好会"
  group.body = "キノコが好きな方、興味のある方向けのコミュニティ。自由にキノコの情報共有しましょう"
  group.owner_id = "2"
end

Group.find_or_create_by!(id: "3") do |group|
  group.g_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-group3.jpg"), filename:"sample-post3.jpg")
  group.title = "お花の写真共有したい！"
  group.body = "良い感じの写真が撮れたら共有しよう！"
  group.owner_id = "3"
end

puts "seedグループ生成完了"



puts "seedグループ組合せ生成開始"
GroupMember.find_or_create_by!(id: "1") do |gmem|
  gmem.user_id = "1"
  gmem.group_id = "1"
  gmem.is_active = "true"
end

GroupMember.find_or_create_by!(id: "2") do |gmem|
  gmem.user_id = "2"
  gmem.group_id = "2"
  gmem.is_active = "true"
end

GroupMember.find_or_create_by!(id: "3") do |gmem|
  gmem.user_id = "3"
  gmem.group_id = "3"
  gmem.is_active = "true"
end


GroupMember.find_or_create_by!(id: "4") do |gmem|
  gmem.user_id = "2"
  gmem.group_id = "1"
  gmem.is_active = "true"
end

GroupMember.find_or_create_by!(id: "5") do |gmem|
  gmem.user_id = "1"
  gmem.group_id = "3"
  gmem.is_active = "true"
end

GroupMember.find_or_create_by!(id: "6") do |gmem|
  gmem.user_id = "1"
  gmem.group_id = "2"
  gmem.is_active = "true"
end


puts "seedグループ組合せ生成完了"



puts "seedグループメッセージ生成開始"
GroupMessage.find_or_create_by!(id: "1") do |gmes|
  gmes.user_id = "1"
  gmes.group_id = "1"
  gmes.body = "珍しい植物を見つけたらおしえてください"
end

GroupMessage.find_or_create_by!(id: "2") do |gmes|
  gmes.user_id = "2"
  gmes.group_id = "2"
  gmes.body = "この時期めっちゃキノコ生えるので見つけたら投稿してください"
end

GroupMessage.find_or_create_by!(id: "3") do |gmes|
  gmes.user_id = "3"
  gmes.group_id = "3"
  gmes.body = "誰か季節ごとの映えスポットとかあったら教えて"
end

GroupMessage.find_or_create_by!(id: "4") do |gmes|
  gmes.user_id = "1"
  gmes.group_id = "2"
  gmes.body = "こっちもキノコ見つけた！"
end

puts "seedグループメッセージ生成完了"



puts "管理者生成開始"
  admin = Admin.find_or_create_by!(email: ENV['AD_EMAIL'] ) do |admin|
  admin.password = ENV['AD_PASSWORD']
end
puts "管理者生成完了"

puts "seed生成完了"