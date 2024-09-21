class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :image
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_messages, dependent: :destroy
  has_many :group_members, dependent: :destroy
  
  has_many :groups, through: :group_members
  
  
  # バリデーション
    validates :name, presence: true
    validates :nickname, presence: true
    validates :email, presence: true
  
  
  
  # プロフ画像呼び出しメソッド
  def show_p_img(width,height)
    # 画像未設定の場合
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  
end
