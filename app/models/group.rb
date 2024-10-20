class Group < ApplicationRecord
    
    has_one_attached :g_image
    
    has_many :group_members, dependent: :destroy
    has_many :group_messages, dependent: :destroy
    
    has_many :users, through: :group_members
    
    # バリデーション
    validates :title, presence: true
    validates :body, presence: true, length: {minimum: 1, maximum: 100}
    
    # グループに参加しているか？（グループとユーザの組み合わせが存在するか）
    # groupに結びついたgroupmembersにuser.idが一致するものがあるか？
    def exist_user?(user)
        group_members.exists?(user_id: user.id)
    end
    
    
    # グループ画像呼び出しメソッド
    def show_g_img(width,height)
        # 画像未設定の場合
        unless g_image.attached?
          file_path = Rails.root.join('app/assets/images/group_no_image.jpg')
          g_image.attach(io: File.open(file_path), filename: 'default-g_image.jpg', content_type: 'image/jpg')
        end
       g_image.variant(resize_to_limit: [width, height]).processed
    end
  
    
end
